//
//  NavigationCoordinator.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import Combine
import SwiftUI
import CoreLocation


protocol NavigationBackHandler {
    func popScreenDueToSwipe()
}

public class NavigationCoordinator {
    
    static let shared = NavigationCoordinator(start: CoordinatorView.StartPoint.splash)
    
    enum Screens {
        case spash
        case login
        case home
    }
    
    public enum TransitAnimation {
        case none
        case opacity
        case fromTrailing
        case fromBottom
        case fluid
        
        var transition: AnyTransition {
            switch self {
            case .none, .opacity, .fluid: return .opacity
            case .fromTrailing: return .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing))
            case .fromBottom: return .asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom))
            }
        }
    }
    
    class ScreenInfo: ObservableObject {
        let screen: Screens
        let animation: TransitAnimation
        var backHandler: NavigationBackHandler? = nil
        
        init(screen: Screens, transition: TransitAnimation) {
            self.screen = screen
            self.animation = transition
        }
    }
    
    static let defaultAnimationDuration = 0.27
    static let fluidAnimationDuration = 0.5
    @ObservedProducer var curStack: [ScreenInfo] = []
    let topScreen = PassthroughSubject<Screens, Never>()
    
    private var issueScreenAdded = false
    private var issuePublisherHolder: AnyCancellable? = nil
    
    init(start: CoordinatorView.StartPoint) {
        curStack.append(.init(screen: start.screen, transition: .none))
        topScreen.send(start.screen)
    }

    func switchStartPoint(_ point: CoordinatorView.StartPoint) {
        print("switchStartPoint \(point)")
        let transition: () -> Void = {
            self.curStack = [.init(screen: point.screen, transition: .none)]
            self.topScreen.send(point.screen)
        }
        makeTransition(transition, withAnimation: .opacity)
    }

    static public func popBack(count: Int = 1, home: Bool = false) {
        let coordinator = NavigationCoordinator.shared
        var popCount = 0
        if home {
            popCount = coordinator.curStack.count - 1
        } else if coordinator.curStack.count > count {
            popCount = count
        }

        let transition: () -> Void = {
            coordinator.curStack.removeLast(popCount)

            if let last = coordinator.curStack.last {
                coordinator.topScreen.send(last.screen)
            }
        }
        coordinator.makeTransition(transition, withAnimation: nil)
    }

    static func pushScreen(_ screen: Screens, withAnimation animation: TransitAnimation = .opacity) {
       let coordinator = NavigationCoordinator.shared

       let transition = {
           coordinator.curStack.append(.init(screen: screen, transition: animation))
           coordinator.topScreen.send(screen)
        }
        coordinator.makeTransition(transition, withAnimation: animation)
    }
    
    private func makeTransition(_ transition:() -> Void, withAnimation animation: TransitAnimation?) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        let currentAnimation = animation ?? .opacity
        switch currentAnimation {
        case .none: transition()
        case .opacity, .fromTrailing, .fromBottom:
            withAnimation(.easeInOut(duration: Self.defaultAnimationDuration)) {
                transition()
            }
        case .fluid:
            withAnimation(.easeInOut(duration: Self.fluidAnimationDuration)) {
                transition()
            }
        }
    }
}

extension CoordinatorView.StartPoint {
    var screen: NavigationCoordinator.Screens {
        switch self {
        case .splash: return .spash
        case .login: return .login
        case .home: return .home
        }
    }
}

