//
//  Divider.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 2/2/2024.
//

import SwiftUI

struct AsDividerModifier: ViewModifier {
    private let color: Color
    
    init(color: Color = .grey05) {
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: 1)
            .background(Color.grey05)
    }
}
