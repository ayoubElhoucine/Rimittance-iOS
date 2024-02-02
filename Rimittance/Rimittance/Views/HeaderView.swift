//
//  HeaderView.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 2/2/2024.
//

import Foundation


import Foundation
import SwiftUI


struct HeaderView: View {
    
    private let title: String
    private let headerHeight: CGFloat
    private let didClose: (() -> Void)?
    private let didBack: (() -> Void)?
    
    init(headerHeight: CGFloat = 110, bgColor: Color = Color.white, title: String, didBack: (() -> Void)? = nil, didClose: (() -> Void)? = nil) {
        self.headerHeight = headerHeight
        self.title = title
        self.didBack = didBack
        self.didClose = didClose
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                if let didBack = didBack {
                    ItemView(icon: "ic_back", didClick: didBack)
                }
                Spacer()
                if let didClose = didClose {
                    ItemView(icon: "ic_close", didClick: didClose)
                }
            }
            Text(title).font(.grey100, .semiBold, 24)
        }
        .padding(EdgeInsets())
        .padding(.horizontal, 16)
        .frame(height: headerHeight)
        .background(Color.white)
    }
    
    @ViewBuilder
    private func ItemView(icon: String, didClick: @escaping () -> Void) -> some View {
        Button(action: didClick) {
            Image(icon)
                .resizable()
                .foregroundColor(.black)
                .scaledToFit()
                .frame(height: 16)
        }
        .frame(width: 36, height: 36)
        .background(Color.grey05)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    HeaderView(title: "Any title", didClose: {})
}
