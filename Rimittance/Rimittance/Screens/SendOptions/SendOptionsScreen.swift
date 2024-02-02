//
//  SendOptionsScreen.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import SwiftUI


fileprivate enum SendOptions {
    case toMonecoBalance, bankTranser, sendToAfrica
    
    var rawValue: (title: String, icon: String) {
        switch self {
        case .toMonecoBalance: return ("to_moneco_balance".localized, "ic_account")
        case .bankTranser: return ("bank_transfer".localized, "ic_market")
        case .sendToAfrica: return ("send_to_africa".localized, "ic_web")
        }
    }
}

struct SendOptionsScreen: View {
    
    private let options = [SendOptions.toMonecoBalance, SendOptions.bankTranser, SendOptions.sendToAfrica]
    
    var body: some View {
        ScreenLayout {
            HeaderView(title: "send_to_africa".localized, didClose: { popBack() })
        } contentFactory: { insets in
            LazyVStack(spacing: 0) {
                Spacer().asDivider()
                ForEach(options, id: \.self) { item in
                    OptionItem(title: item.rawValue.title, icon: item.rawValue.icon) {
                        if item == .sendToAfrica {
                            pushScreen(.sendDestination)
                        }
                    }
                    Spacer().asDivider()
                }
            }
            .padding(insets)
            .padding(.top, 16)
        }
    }
}

#Preview {
    SendOptionsScreen()
}
