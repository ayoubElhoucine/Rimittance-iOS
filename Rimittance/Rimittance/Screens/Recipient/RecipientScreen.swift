//
//  RecipientScreen.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import SwiftUI

struct RecipientScreen: View {
    @StateObject private var model = Model()
    
    private let pages = [RecipientPages.previous, RecipientPages.new]
    
    var body: some View {
        ScreenLayout {
            HeaderView(title: "who_sending".localized, didBack: popBack)
        } contentFactory: { insets in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    PagesTabSection()
                    SearchTextField(didChange: model.filter)
                    
                    switch model.selectedPage {
                    case .previous: 
                        PreviousRecipientPage(model: model) { recipient in
                                pushScreen(.walletOptions(recipient))
                        }
                    case .new: 
                        NewRecipientPage(model: model)
                    }
                }.padding(insets)
            }.padding(.bottom, insets.bottom)
            FooterSection().padding(.bottom, insets.bottom)
        }
        .setupDefaultBackHandler()
        .background(Color.white.shadow(color: .grey25, radius: 300).ignoresSafeArea())
    }
    
    @ViewBuilder
    private func PagesTabSection() -> some View {
        HStack(spacing: 0) {
            ForEach(0 ..< pages.count, id: \.self) { index in
                let item = pages[index]
                PageItem(title: item.title, isSelected: model.selectedPage == item) {
                    model.setPage(item)
                }
            }
        }
        .padding(2)
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
        switch model.selectedPage {
        case .previous:
            EmptyView()
        case .new:
            VStack {
                Spacer()
                FooterView {
                    pushScreen(.walletOptions(model.createRecipient()))
                }
            }.clipped()
        }
    }
}

#Preview {
    RecipientScreen()
}
