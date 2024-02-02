//
//  MyButton.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 2/2/2024.
//

import Foundation

import Foundation
import SwiftUI


struct WasaliButton<Content: View>: View {
    private let color: Color
    private let content: () -> Content
    private let action: () -> Void
    private let disabled: Bool
    private let radius: Double
    private let elevation: Double
    
    init(color: Color = .primary100, disabled: Bool = false, radius: Double = 16, elevation: Double = 0.5, @ViewBuilder content: @escaping () -> Content, action: @escaping () -> Void){
        self.color = color
        self.content = content
        self.action = action
        self.disabled = disabled
        self.radius = radius
        self.elevation = elevation
    }
    
    var body: some View {
        Button(action: self.action, label: self.content)
            .disabled(self.disabled)
            .frame(maxWidth: .infinity, maxHeight: 55)
            .cornerRadius(radius)
            .background(RoundedRectangle(cornerRadius: radius).fill(disabled ? Color.secondary.opacity(0.2) : color)
            .shadow(radius: elevation))
    }
}
