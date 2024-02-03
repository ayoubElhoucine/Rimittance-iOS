//
//  SendDestinationScreen.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import SwiftUI


fileprivate enum SendToAfricaOptions {
    case mobileWallet, bankTranser
    
    var title: String {
        return switch self {
        case .mobileWallet: "mobile_wallets".localized
        case .bankTranser: "bank_transfer".localized
        }
    }
}

struct SendDestinationScreen: View {
    
    private let options = [SendToAfricaOptions.mobileWallet, SendToAfricaOptions.bankTranser]
    
    var body: some View {
        ScreenLayout {
            HeaderView(title: "send_to_africa".localized, didBack: popBack)
        } contentFactory: { insets in
            VStack(spacing: 0) {
                Spacer().asDivider()
                ForEach(options, id: \.self) { item in
                    OptionItem(title: item.title, icon: "ic_arrow_send") {
                        pushScreen(.recipient, withAnimation: .fromTrailing)
                    }
                    Spacer().asDivider()
                }
            }
            .padding(insets)
            .padding(.top, 16)
        }
        .setupDefaultBackHandler()
        .background(Color.white.shadow(color: .grey25, radius: 300).ignoresSafeArea())
    }
}

#Preview {
    SendDestinationScreen()
}
