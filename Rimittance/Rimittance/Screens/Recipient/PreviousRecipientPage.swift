//
//  PreviousRecipientView.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 3/2/2024.
//

import SwiftUI


extension RecipientScreen {
    struct PreviousRecipientPage: View {
        
        @StateObject var viewModel: ViewModel
        let didSelect: (Recipient) -> Void
        
        var body: some View {
            switch viewModel.previousUiState {
            case .loading: 
                Loading()
            case .empty:
                Empty()
            case .success(let data): 
                Success(data, didSelect: didSelect)
            case .failed(_): 
                FailView(action: viewModel.retryGetRecipients).padding(.top, 50)
            }
        }
        
        @ViewBuilder
        private func Loading() -> some View {
            CircularProgress().padding(.top, 50)
        }
        
        @ViewBuilder
        private func Empty() -> some View {
            VStack {
                Image("bg_empty")
                    .resizable()
                    .padding(.horizontal, 80)
                    .scaledToFit()
                Text("no_result".localized).font(.grey70, .medium, 16)
            }.padding(16)
        }
        
        @ViewBuilder
        private func Success(_ data: [Recipient], didSelect: @escaping (Recipient) -> Void) -> some View {
            VStack(alignment: .leading, spacing: 16) {
                Text("contact_phone".localized).font(.grey100, .medium, 14).padding(.horizontal, 16)
                LazyVStack(spacing: 0) {
                    Spacer().asDivider()
                    ForEach(data, id: \.self) { item in
                        Button {
                            didSelect(item)
                        } label: {
                            HStack(spacing: 8) {
                                RoundedRectangle(cornerRadius: 8).fill(Color.grey05)
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                        VStack(spacing: 4) {
                                            Circle().fill(Color.grey25).frame(height: 12)
                                            Capsule().fill(Color.grey25).frame(width: 22, height: 10)
                                        }
                                    }
                                VStack(alignment: .leading) {
                                    Text(item.name).font(.grey100, .medium, 16)
                                    Text("+229 98 767 289").font(.grey50, .regular, 14)
                                }
                                Spacer()
                                Image("ic_arrow_right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 12)
                            }.padding(16)
                        }
                        Spacer().asDivider()
                    }
                }
            }.padding(.vertical, 26)
        }
    }
}
