//
//  View.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import SwiftUI
import Combine

extension View {
    
    func popBack() {
        NavigationCoordinator.popBack(count: 1, home: false)
    }
    
    func popBack(count: Int = 1, home: Bool = false) {
        NavigationCoordinator.popBack(count: count, home: home)
    }

    func pushScreen(_ screen: NavigationCoordinator.Screens, withAnimation animation: NavigationCoordinator.TransitAnimation = .opacity) {
        NavigationCoordinator.pushScreen(screen, withAnimation: animation)
    }
}

extension Spacer {
    func asDivider() -> some View {
        self.modifier(AsDividerModifier())
    }
}

@available(iOS 13.0, *)
public struct RoundedCorner: Shape {

    public var radius: CGFloat = .infinity
    public var corners: UIRectCorner = .allCorners
    
    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }

    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

extension View {
    func setupDefaultBackHandler(home: Bool = false) -> some View {
        self.modifier(BackHandlerModifier(popToHome: home, handler: nil))
    }
    
    func setupBackHandler(_ handler: NavigationBackHandler) -> some View {
        self.modifier(BackHandlerModifier(popToHome: false, handler: handler))
    }
}

struct BackHandlerModifier: ViewModifier, NavigationBackHandler {
    let popToHome: Bool
    let handler: NavigationBackHandler?
    
    func popScreenDueToSwipe() {
        NavigationCoordinator.popBack(home: popToHome)
    }
    
    @EnvironmentObject private var screenInfo: NavigationCoordinator.ScreenInfo
    
    func body(content: Content) -> some View {
       content
            .onAppear {
                screenInfo.backHandler = handler ?? self
            }
    }
}
