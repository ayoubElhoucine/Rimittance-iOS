//
//  SearchTextField.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 2/2/2024.
//

import SwiftUI

struct SearchTextField: View {
    @Binding var value: String
    let onChange: (String) -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Image("ic_search")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.grey50)
                .scaledToFit()
                .frame(width: 14, height: 14)
            TextField("search".localized, text: $value)
                .font(.custom("Outfit-Regular", size: 15))
                .autocorrectionDisabled(true)
                .onChange(of: value, perform: onChange)
                .submitLabel(.done)
        }
        .padding(.horizontal, 16)
        .frame(height: 40)
        .background(Color.grey05)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
