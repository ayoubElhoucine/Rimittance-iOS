//
//  NewRecipientView.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 3/2/2024.
//

import SwiftUI


extension RecipientScreen {
    struct NewRecipientPage: View {
        
        @StateObject var viewModel: ViewModel
        
        var body: some View {
            switch viewModel.newUiState {
            case .loading: 
                Loading()
            case .success(let data): 
                Success(data, didSelect: viewModel.setSelectedCountry)
            default: 
                FailView(action: viewModel.retryGetRecipients).padding(.top, 50)
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
                if let selectedCountry = viewModel.selectedCountry {
                    CountrySelector(selectedCountry: selectedCountry, countries: data, didSelect: didSelect)
                }
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
                    Spacer().asDivider(color: .grey15)
                    Text("add_manually".localized.uppercased()).font(.grey50, .semiBold, 12)
                    Spacer().asDivider(color: .grey15)
                }.padding(.vertical, 10)
                ForEach(["phone_number", "first_name", "last_name"], id: \.self) { item in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(item.localized).font(.grey100, .regular, 16)
                        HStack {
                            Text("Enter value").font(.grey50, .regular, 16)
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .frame(height: 52)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.grey15, lineWidth: 1))
                    }.padding(.top, 12)
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.top, 26)
            .padding(.bottom, 40)
            .padding(.horizontal, 16)
        }
    }
}
