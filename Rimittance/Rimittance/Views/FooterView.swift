//
//  FooterView.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 2/2/2024.
//

import SwiftUI

struct FooterView: View {
    private let disabled: Bool
    private let action: () -> Void
    
    init(disabled: Bool = false, action: @escaping () -> Void) {
        self.disabled = disabled
        self.action = action
    }
    
    var body: some View {
        ZStack {
            MyButton(disabled: disabled, title: "next".localized, action: action)
                .padding(16)
        }.background(Color.white.shadow(color: .grey15, radius: 10))
    }
}

#Preview  {
    FooterView(disabled: true, action: {})
}
