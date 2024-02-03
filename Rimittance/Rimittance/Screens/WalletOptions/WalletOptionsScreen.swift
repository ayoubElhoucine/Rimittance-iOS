//
//  WalletOptionsScreen.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import SwiftUI

struct WalletOptionsScreen: View {
    
    @StateObject private var model = Model()
    
    let recipient: Recipient
    
    var body: some View {
        ScreenLayout {
            HeaderView(title: "choose_wallet".localized, didBack: popBack)
        } contentFactory: { insets in
            switch model.uiState {
            case .loading:
                Loading()
            case .success(let data):
                Success(data).padding(insets)
            default:
                Fail(action: model.retryGetWallet)
            }
        }
        .setupDefaultBackHandler(home: true)
    }
    
    @ViewBuilder
    private func Loading() -> some View {
        ZStack {
            CircularProgress()
        }.frame(maxHeight: .infinity)
    }
    
    @ViewBuilder
    private func Fail(action: @escaping () -> Void) -> some View {
        ZStack {
            FailView(action: action)
        }.frame(maxHeight: .infinity)
    }
    
    @ViewBuilder
    private func Success(_ data: [Wallet]) -> some View {
        LazyVStack(spacing: 16) {
            ForEach(data, id: \.self) { item in
                WalletItem(item, isSelected: item == model.selectedWallet)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        
        VStack {
            Spacer()
            FooterView(disabled: model.selectedWallet == nil) {
                pushScreen(.invoice(model.getUpdateRecipient(recipient)))
            }
        }.clipped()
    }
    
    @ViewBuilder
    private func WalletItem(_ wallet: Wallet, isSelected: Bool) -> some View {
        Button {
            model.setSelectedWallet(wallet)
        } label: {
            HStack(spacing: 16) {
                Image(image(wallet))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                Text(wallet.name).font(.grey100, .medium, 16)
                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(height: 72)
            .background(RoundedRectangle(cornerRadius: 12).fill(isSelected ? Color.primary05 : .clear))
            .overlay {
                RoundedRectangle(cornerRadius: 12).strokeBorder(isSelected ? Color.primary100 : .grey15, lineWidth: isSelected ? 1.5 : 1)
            }
        }
    }
}

extension WalletOptionsScreen {
    fileprivate func image(_ wallet: Wallet) -> String {
        return switch wallet.id {
        case "1": "image_wave"
        case "2": "image_mtn"
        case "3": "image_orange"
        default: "image_wave"
        }
    }
}
