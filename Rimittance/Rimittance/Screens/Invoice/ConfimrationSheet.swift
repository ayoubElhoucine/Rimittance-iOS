//
//  ConfimrationSheet.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 3/2/2024.
//

import SwiftUI


extension InvoiceScreen {
    struct ConfimrationSheet: View {
        
        let recipient: Recipient
        let sendingValue: Double
        let didConfirm: () -> Void
        
        var body: some View {
            VStack(alignment: .leading, spacing: 24) {
                ZStack {
                    Capsule().fill(Color.grey15).frame(width: 70, height: 6)
                }.padding(.top, 10).frame(maxWidth: .infinity)
                Text("confirm_transfer".localized).font(.grey100, .semiBold, 24)
                ViewItem(title: "you_sending", value: "\(sendingValue) XOF")
                ViewItem(title: "to", value: recipient.name)
                ViewItem(title: "via", value: recipient.mobileWallet ?? "").padding(.bottom, 16)
                MyButton(title: "confirm".localized, action: didConfirm).frame(height: 56)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 8)
            .background(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]).fill(.white).shadow(radius: 2).ignoresSafeArea())
        }
        
        @ViewBuilder
        private func ViewItem(title: String, value: String) -> some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(title.localized).font(.grey50, .regular, 14)
                Text(value).font(.grey100, .semiBold, 18)
            }
        }
    }
}
