//
//  RecipientScreenModel.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 2/2/2024.
//

import Foundation
import Combine


extension RecipientScreen {
    class ViewModel: ObservableObject {
        
        private var cancellables: Set<AnyCancellable> = []
        
        @Published private(set) var previousUiState: UiState<[Recipient]> = .loading
        @Published private(set) var newUiState: UiState<[Country]> = .loading
        
        @Published private(set) var selectedPage: RecipientPages = .previous
        @Published private(set) var selectedCountry: Country? = nil
        
        private var recipientList: [Recipient]? = nil
        
        init() {
            getRecipients()
            getCountries()
        }
        
        deinit {
            cancellables.removeAll()
            RecipientRepo.destroy()
            CountryRepo.destroy()
        }
        
        private func getRecipients() {
            RecipientRepo.shared.fetchRecipients()?
                .sink { [weak self] (dataResponse) in
                    switch dataResponse.result {
                    case .success(let data):
                        self?.recipientList = data
                        if data.isEmpty {
                            self?.previousUiState = .empty
                        } else {
                            self?.previousUiState = .success(data)
                        }
                    case .failure(let error):
                        self?.previousUiState = .failed(error.message)
                    }
                }.store(in: &cancellables)
        }
        
        private func getCountries() {
            CountryRepo.shared.fetchCountries()?
                .sink { [weak self] (dataResponse) in
                    switch dataResponse.result {
                    case .success(let data):
                        self?.selectedCountry = data.first
                        self?.newUiState = .success(data)
                    case .failure(let error):
                        self?.newUiState = .failed(error.message)
                    }
                }.store(in: &cancellables)
        }
        
        func retryGetRecipients() {
            previousUiState = .loading
            getRecipients()
        }
        
        func retryGetCountries() {
            newUiState = .loading
            getCountries()
        }
        
        func filter(_ text: String) {
            if text.isEmpty, let data = recipientList {
                previousUiState = .success(data)
            } else {
                let data = recipientList?.filter {
                    "\($0.id)\($0.name)\($0.country ?? "")\($0.mobileWallet ?? "")".lowercased().contains(text.lowercased())
                }
                if let data = data, !data.isEmpty {
                    previousUiState = .success(data)
                } else {
                    previousUiState = .empty
                }
            }
        }
        
        func setPage(_ value: RecipientPages) {
            selectedPage = value
        }
        
        func setSelectedCountry(_ value: Country) {
            selectedCountry = value
        }
        
        func createRecipient() -> Recipient {
            return Recipient(id: "12", name: "New recipient name", country: selectedCountry?.name, mobileWallet: nil)
        }
    }
}


extension RecipientScreen {
    enum RecipientPages {
        case previous, new
        
        var title: String {
            return switch self {
            case .previous: "prev_recipient".localized
            case .new: "new_recipient".localized
            }
        }
    }
}
