//
//  WalletOptionsScreenModel.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 3/2/2024.
//

import Foundation


extension WalletOptionsScreen {
    class Model: ObservableObject {
        
        @Published private(set) var uiState: UiState<[Wallet]> = .loading
        @Published private(set) var selectedWallet: Wallet? = nil
        
        init() {
            getWallets()
        }
        
        private func getWallets() {
            WalletRepo.shared.getWallets { [weak self] data in
                self?.uiState = .success(data)
            } failed: { [weak self] error in
                self?.uiState = .failed(error?.message)
            }
        }
        
        func retryGetWallet() {
            uiState = .loading
            getWallets()
        }
        
        func setSelectedWallet(_ value: Wallet) {
            if selectedWallet == value {
                selectedWallet = nil
            } else {
                selectedWallet = value
            }
        }
        
        func getUpdateRecipient(_ recipient: Recipient) -> Recipient {
            return Recipient(
                id: recipient.id,
                name: recipient.name,
                country: recipient.country,
                mobileWallet: selectedWallet?.name
            )
        }
    }
}
