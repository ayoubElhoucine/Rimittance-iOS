//
//  RecipientScreen.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import SwiftUI

struct RecipientScreen: View {
    @StateObject private var viewModel = ViewModel()
    
    private let pages = [RecipientPages.previous, RecipientPages.new]
    
    var body: some View {
        ScreenLayout {
            HeaderView(title: "who_sending".localized, didBack: popBack)
        } contentFactory: { insets in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    PagesTabSection()
                    SearchTextField(didChange: viewModel.filter)
                    
                    switch viewModel.selectedPage {
                    case .previous: 
                        PreviousRecipientPage(viewModel: viewModel) { recipient in
                                pushScreen(.walletOptions(recipient))
                        }
                    case .new: 
                        NewRecipientPage(viewModel: viewModel)
                    }
                }.padding(insets)
            }.padding(.bottom, insets.bottom + 40)
            FooterSection().padding(.bottom, insets.bottom)
        }
        .setupDefaultBackHandler()
        .background(Color.white.shadow(color: .grey25, radius: 300).ignoresSafeArea())
        .onTapGesture(perform: UIApplication.shared.endEditing)
    }
    
    @ViewBuilder
    private func PagesTabSection() -> some View {
        HStack(spacing: 0) {
            ForEach(pages, id: \.self) { item in
                PageItem(title: item.title, isSelected: viewModel.selectedPage == item) {
                    viewModel.setPage(item)
                }
            }
        }
        .padding(1)
        .frame(maxWidth: .infinity)
        .frame(height: 46)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.primary05))
        .padding(16)
    }
    
    @ViewBuilder
    private func PageItem(title: String, isSelected: Bool, didClick: @escaping () -> Void) -> some View {
        Button(action: didClick) {
            ZStack {
                Text(title).font(isSelected ? .white : .primary100, .medium, 14)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(isSelected ? Color.primary70 : .clear)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .padding(2)
        }
    }
    
    @ViewBuilder
    private func FooterSection() -> some View {
        switch viewModel.selectedPage {
        case .previous:
            EmptyView()
        case .new:
            switch viewModel.newUiState {
            case .success(_):
                VStack {
                    Spacer()
                    FooterView {
                        pushScreen(.walletOptions(viewModel.createRecipient()))
                    }
                }.clipped()
            default: EmptyView()
            }
        }
    }
}

#Preview {
    RecipientScreen()
}
