//
//  TransactionsView.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 2/2/2024.
//

import SwiftUI

extension HomeScreen {
    struct TransactionsSection: View {
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text("transactions".localized).font(.grey100, .semiBold, 18)
                LazyVStack(spacing: 0) {
                    ForEach(0 ..< 4, id: \.self) { index in
                        TransationItem()
                        if index < 3 {
                            Spacer().asDivider()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 16).fill(.white).shadow(color: .grey05, radius: 10))
            }.padding(16)
        }
        
        @ViewBuilder
        private func TransationItem() -> some View {
            HStack(spacing: 10) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue10)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image("ic_arrow_transaction")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.blue100)
                            .scaledToFit()
                            .frame(width: 16)
                    }
                VStack(alignment: .leading) {
                    Text("sent_to".localized).font(.grey50, .regular, 12)
                    Text("Ralph Edwards").font(.grey100, .medium, 16)
                }
                Spacer()
                Text("€ 150").font(.grey100, .medium, 14)
            }.padding(18)
        }
    }
}

#Preview {
    HomeScreen.TransactionsSection()
}
