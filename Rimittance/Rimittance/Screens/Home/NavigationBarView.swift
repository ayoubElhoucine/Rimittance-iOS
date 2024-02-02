//
//  NavigationBarView.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 2/2/2024.
//

import SwiftUI

fileprivate enum Tabs {
    case home, cards, send, tonotines, settings
    
    var rawValue: (title: String, icon: String) {
        switch self {
        case .home: return ("home".localized, "ic_home")
        case .cards: return ("cards".localized, "ic_credit")
        case .send: return ("send".localized, "Database")
        case .tonotines: return ("tontines".localized, "ic_money")
        case .settings: return ("settings".localized, "ic_setting")
        }
    }
}

extension HomeScreen {
    struct NavigationBarView: View {
        let didSelect: () -> Void
        
        private let tabs = [Tabs.home, Tabs.cards, Tabs.send, Tabs.tonotines, Tabs.settings]
        
        var body: some View {
            VStack(spacing: 0) {
                Spacer().frame(maxWidth: .infinity).frame(height: 1).background(Color.grey05)
                HStack(spacing: 0) {
                    ForEach(0 ..< tabs.count, id: \.self) { index in
                        let item = tabs[index]
                        if item == .send {
                            SendItem(didClick: didSelect)
                        } else {
                            TabItem(
                                title: item.rawValue.title,
                                icon: item.rawValue.icon,
                                isSeleted: item == .home,
                                didClick: {}
                            )
                        }
                    }
                }
                .padding(.vertical, 10)
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 68)
            .background(.white)
        }
        
        @ViewBuilder
        private func TabItem(title: String, icon: String, isSeleted: Bool, didClick: () -> Void) -> some View {
            VStack {
                Image(icon)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(isSeleted ? .primary100 : .grey50)
                    .scaledToFit()
                    .frame(width: 22)
                Text(title)
                    .font(isSeleted ? .primary100 : .grey50, isSeleted ? .semiBold : .regular, 12)
            }.frame(maxWidth: .infinity)
        }
        
        @ViewBuilder
        private func SendItem(didClick: () -> Void) -> some View {
            ZStack {
                Circle()
                    .fill(Color.accent100)
                    .shadow(color: .grey15, radius: 6)
                    .frame(width: 50, height: 50)
                    .overlay {
                        Image("ic_send")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
            }.frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    HomeScreen.NavigationBarView(didSelect: {})
}
