//
//  ScreenLayout.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 2/2/2024.
//

import SwiftUI


public struct ScreenLayout<Header: View, Content: View>: View {
    private let color: Color
    private let header: Header
    private let headerHeight: CGFloat
    private let contentFactory: (EdgeInsets) -> Content
    
    public init(headerHeight: CGFloat? = nil, color: Color = .white, @ViewBuilder headerFactory: () -> Header, @ViewBuilder contentFactory: @escaping (EdgeInsets) -> Content) {
        self.header = headerFactory()
        self.contentFactory = contentFactory
        self.headerHeight = headerHeight ?? 100
        self.color = color
    }
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                contentFactory(
                    EdgeInsets(
                        top: proxy.safeAreaInsets.top + headerHeight,
                        leading: proxy.safeAreaInsets.leading,
                        bottom: proxy.safeAreaInsets.bottom,
                        trailing: proxy.safeAreaInsets.trailing))
                    .ignoresSafeArea()
                
                header
            }
        }.background(color)
    }
}
