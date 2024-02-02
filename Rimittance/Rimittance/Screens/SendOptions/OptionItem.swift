//
//  SendOptionItem.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 2/2/2024.
//

import SwiftUI

struct OptionItem: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.primary05)
                .frame(width: 40, height: 40)
                .overlay {
                    Image(icon)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.primary100)
                        .scaledToFit()
                        .frame(width: 18)
                }
            Text(title).font(.grey100, .medium, 16)
            Spacer()
            Image("ic_arrow_right")
                .resizable()
                .scaledToFit()
                .frame(height: 12)
        }.padding(16)
    }
}
