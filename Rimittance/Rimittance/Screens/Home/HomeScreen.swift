//
//  HomeScreen.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var model = Model()
    
    var body: some View {
        ScreenLayout(headerHeight: 0, color: .primary05) {
            EmptyView()
        } contentFactory: { insets in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    UserInfoSection()
                    BalanceSection()
                    HomeActionsSection()
                    TransactionsSection()
                }
                .padding(.top, insets.top + 16)
                .padding(.bottom, insets.bottom + 76)
            }
            VStack {
                Spacer()
                NavigationBarView {
                    pushScreen(.sendOptions)
                }.padding(.bottom, insets.bottom)
            }
        }
    }
    
    @ViewBuilder
    private func UserInfoSection() -> some View {
        HStack {
            Text("Hey, John Doe").font(.grey100, .semiBold, 22)
            Spacer()
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.grey05)
                .frame(width: 40, height: 40)
                .overlay {
                    Image("ic_bell")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 24)
                }
        }.padding(16)
    }
    
    @ViewBuilder
    private func BalanceSection() -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("your_balance").font(.white, .regular, 18)
                Spacer()
                Text("320.000").font(.white, .semiBold, 24)
                Text("US Dollars").font(.white, .regular, 14)
            }
            Spacer()
            Image("ic_wallet_card")
                .resizable()
                .frame(width: 56, height: 56)
        }
        .padding(20)
        .frame(height: 160)
        .background(LinearGradient(gradient: Gradient(colors: [.walletGreen1, .walletGreen2]), startPoint: .leading, endPoint: .trailing))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#Preview {
    HomeScreen()
}
