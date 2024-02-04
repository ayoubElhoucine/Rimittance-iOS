//
//  WalletOptionsScreenModel.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 3/2/2024.
//

import Foundation
import Combine


extension WalletOptionsScreen {
    class ViewModel: ObservableObject {
        
        private var cancellables: Set<AnyCancellable> = []
        
        @Published private(set) var uiState: UiState<[Wallet]> = .loading
        @Published private(set) var selectedWallet: Wallet? = nil
        
        init() {
            getWallets()
        }
        
        deinit {
            cancellables.removeAll()
            WalletRepo.destroy()
        }
        
        private func getWallets() {
            WalletRepo.shared.fetchWallets()
                .sink { [weak self] (dataResponse) in
                    switch dataResponse.result {
                    case .success(let data):
                        self?.uiState = .success(data)
                    case .failure(let error):
                        self?.uiState = .failed(error.message)
                    }
                }.store(in: &cancellables)
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
