//
//  MyButton.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 2/2/2024.
//

import Foundation

import Foundation
import SwiftUI


struct MyButton: View {
    private let color: Color
    private let title: String
    private let action: () -> Void
    private let disabled: Bool
    private let radius: Double
    private let elevation: Double
    
    init(color: Color = .primary100, disabled: Bool = false, radius: Double = 16, elevation: Double = 0.5, title: String, action: @escaping () -> Void){
        self.color = color
        self.title = title
        self.action = action
        self.disabled = disabled
        self.radius = radius
        self.elevation = elevation
    }
    
    var body: some View {
        Button(action: self.action) {
            Text(title).font(.white, .medium, 16)
                .frame(maxWidth: .infinity)
        }
        .disabled(self.disabled)
        .frame(maxWidth: .infinity, maxHeight: 55)
        .cornerRadius(radius)
        .background(RoundedRectangle(cornerRadius: radius).fill(disabled ? color.opacity(0.1) : color)
        .shadow(radius: disabled ? 0 : elevation))
    }
}
