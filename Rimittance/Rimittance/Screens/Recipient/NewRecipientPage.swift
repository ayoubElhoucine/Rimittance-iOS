//
//  NewRecipientView.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 3/2/2024.
//

import SwiftUI


extension RecipientScreen {
    struct NewRecipientPage: View {
        
        @StateObject var model: Model
        let didCreate: (Recipient) -> Void
        
        var body: some View {
            switch model.newUiState {
            case .loading: Loading()
            case .success(let data): Success(data, didSelect: model.setSelectedCountry, didCreate: didCreate)
            default: FailView(action: model.retryGetRecipients).padding(.top, 50)
            }
        }
        
        @ViewBuilder
        private func Loading() -> some View {
            CircularProgress().padding(.top, 50)
        }
        
        @ViewBuilder
        private func Success(_ data: [Country], didSelect: @escaping (Country) -> Void, didCreate: @escaping (Recipient) -> Void) -> some View {
            VStack(alignment: .leading, spacing: 10) {
                Text("country".localized).font(.grey100, .regular, 16)
                if let selectedCountry = model.selectedCountry {
                    CountrySelector(selectedCountry: selectedCountry, countries: data, didSelect: didSelect)
                }
            }
            .padding(.vertical, 26)
            .padding(.horizontal, 16)
        }
    }
}
