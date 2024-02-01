//
//  CoordinatorViewStackTrigger.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import Foundation
import SwiftUI


private struct GlobalNamespaceKey: EnvironmentKey {
    static var defaultValue: Namespace.ID? {
        nil
    }
}

extension EnvironmentValues {
    var globalNamespace: Namespace.ID? {
        get { self[GlobalNamespaceKey.self] }
        set { self[GlobalNamespaceKey.self] = newValue}
    }
}

extension CoordinatorView {
    struct StackTrigger: View {
        private let coordinator: NavigationCoordinator
        @ObservedConsumer private var stack: [NavigationCoordinator.ScreenInfo]
        @Namespace private var globalNamespace
        @Environment(\.layoutDirection) private var layoutDirection
        
        init(_ coordinator: NavigationCoordinator) {
            self.coordinator = coordinator
            _stack = coordinator.$curStack
        }
        
        var body: some View {
            ForEach(Array(zip(stack.indices, stack)), id: \.0) { index, item in
                let screen = ScreenFromInfo(item.screen)
                screen
                    .transition(item.animation.transition)
                    .zIndex(Double(index))
                    .environmentObject(item)
                    .disabled(index < stack.count - 1)
            }
            .environment(\.globalNamespace, globalNamespace)
            .simultaneousGesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
                        .onEnded { value in
                            var needPop = false
                            if abs(value.translation.height) < abs(value.translation.width) {
                                if abs(value.translation.width) > 50.0 {
                                    if value.translation.width < 0 {
                                        print("swipeRightToLeft()")
                                        if layoutDirection == .rightToLeft {
                                            needPop = true
                                        }
                                    } else if value.translation.width > 0 {
                                        print("swipeLeftToRight()")
                                        if layoutDirection == .leftToRight {
                                            needPop = true
                                        }
                                    }
                                }
                            }
                            
                            if needPop, let handler = coordinator.curStack.last?.backHandler {
                                handler.popScreenDueToSwipe()
                            }
                        }
                    )
        }
        
        @ViewBuilder
        private func ScreenFromInfo(_ screen: NavigationCoordinator.Screens) -> some View {
            switch screen {
            case .home: HomeScreen()
            case .sendOptions: SendOptionsScreen()
            case .sendDestination: SendDestinationScreen()
            case .recipient: RecipientScreen()
            case .walletOptions(let recipient): WalletOptionsScreen(recipient: recipient)
            case .invoice(let recipient): InvoiceScreen(recipient: recipient)
            case .success: SuccessScreen()
            }
        }
    }
}
