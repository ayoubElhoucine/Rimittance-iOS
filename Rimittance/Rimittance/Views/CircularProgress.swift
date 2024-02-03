//
//  CircularProgress.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 2/2/2024.
//

import Foundation
import SwiftUI


struct CircularProgress: View {
    
    private let color: Color
    private let scale: CGFloat
    
    init(color: Color = Color.grey70, scale: CGFloat = 1.2) {
        self.color = color
        self.scale = scale
    }
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: color))
            .scaleEffect(x: scale, y: scale, anchor: .center)
    }
}
