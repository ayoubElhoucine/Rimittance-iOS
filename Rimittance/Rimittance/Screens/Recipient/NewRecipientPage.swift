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
        
        var body: some View {
            switch model.newUiState {
            case .loading: 
                Loading()
            case .success(let data): 
                Success(data, didSelect: model.setSelectedCountry)
            default: 
                FailView(action: model.retryGetRecipients).padding(.top, 50)
            }
        }
        
        @ViewBuilder
        private func Loading() -> some View {
            CircularProgress().padding(.top, 50)
        }
        
        @ViewBuilder
        private func Success(_ data: [Country], didSelect: @escaping (Country) -> Void) -> some View {
            VStack(alignment: .leading, spacing: 10) {
                Text("country".localized).font(.grey100, .regular, 16)
                if let selectedCountry = model.selectedCountry {
                    CountrySelector(selectedCountry: selectedCountry, countries: data, didSelect: didSelect)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.primary05)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8).strokeBorder(Color.primary15, lineWidth: 1)
                                .overlay {
                                    HStack {
                                        Image("ic_list")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 16)
                                        Text("choose_contact".localized).font(.primary100, .semiBold, 16)
                                    }
                                }
                        }
                        .padding(.vertical, 16)
                    HStack(spacing: 6) {
                        Spacer().asDivider()
                        Text("add_manually".localized.uppercased()).font(.grey50, .semiBold, 12)
                        Spacer().asDivider()
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.vertical, 26)
            .padding(.horizontal, 16)
        }
    }
}
