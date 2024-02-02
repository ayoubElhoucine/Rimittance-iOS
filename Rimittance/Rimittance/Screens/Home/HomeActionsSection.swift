//
//  HomeActionsView.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 2/2/2024.
//

import SwiftUI


fileprivate enum Actions {
    case topUp, withdraw, getIban, analytics
    
    var rawValue: (title: String, icon: String) {
        switch self {
        case .topUp: return ("top_up".localized, "ic_wallet_add")
        case .withdraw: return ("withdraw_money".localized, "ic_wallet")
        case .getIban: return ("get_iban".localized, "ic_card")
        case .analytics: return ("view_analytics".localized, "ic_analytics")
        }
    }
}

extension HomeScreen {
    struct HomeActionsSection: View {
        
        private let actions = [Actions.topUp, Actions.withdraw, Actions.getIban, Actions.analytics]
        private let adaptiveColumn = [
            GridItem(.adaptive(minimum: 100), spacing: 16),
            GridItem(.adaptive(minimum: 100), spacing: 16)
        ]
        
        var body: some View {
            LazyVGrid(columns: adaptiveColumn, spacing: 16) {
                ForEach(actions, id: \.self) { item in
                    ActionItem(title: item.rawValue.title, icon: item.rawValue.icon)
                }
            }.padding(16)
        }
        
        @ViewBuilder
        private func ActionItem(title: String, icon: String) -> some View {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.primary05)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(icon)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.primary100)
                                .scaledToFit()
                                .frame(width: 24)
                        }
                    Text(title).font(.primary100, .medium, 14)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(18)
            .background(RoundedRectangle(cornerRadius: 16).fill(.white).shadow(color: .grey05, radius: 10))
        }
    }
}

#Preview {
    HomeScreen.HomeActionsSection()
}
