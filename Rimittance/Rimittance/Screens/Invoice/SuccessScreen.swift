//
//  SuccessScreen.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import SwiftUI

struct SuccessScreen: View {
    var body: some View {
        ScreenLayout(color: .primary70) {
            EmptyView()
        } contentFactory: { insets in
            VStack(spacing: 0) {
                Spacer()
                Image("bg_success")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 70)
                Text("success_transfer_msg".localized).font(.white, .semiBold, 24)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                MyButton(title: "got_it".localized) {
                    popBack(home: true)
                }.padding(.top, 30).padding(.bottom, 70)
                Spacer()
            }.padding(16)
        }
        .setupDefaultBackHandler(home: true)
    }
}

#Preview {
    SuccessScreen()
}
