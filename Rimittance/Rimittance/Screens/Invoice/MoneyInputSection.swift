//
//  MoneyInputSection.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 3/2/2024.
//

import SwiftUI

extension InvoiceScreen {
    struct MoneyInputSection: View {
        
        @StateObject var model: Model
        
        @State private var value: String = ""
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text("how_you_sending").font(.grey100, .medium, 16)
                VStack(spacing: 0) {
                    HStack {
                        TextField("0.0", text: $value)
                            .accentColor(.grey50)
                            .font(.custom(Font.RimittanceFont.regular.rawValue, size: 18))
                            .keyboardType(.numberPad)
                            .autocorrectionDisabled(true)
                            .onChange(of: value, perform: model.calculate)
                            .submitLabel(.done)
                        Spacer()
                        Text("EUR").font(.grey50, .medium, 18)
                    }.padding(16)
                    Spacer().frame(maxWidth: .infinity).frame(height: 1).background(contentBorderColor(model.uiState))
                    HStack(spacing: 0) {
                        Text("your_current_balance".localized).font(.grey100, .regular, 12)
                        Text("  230 EUR").font(.grey100, .bold, 12)
                        Spacer()
                    }
                    .padding(10)
                    .background(containerColor(model.uiState))
                }
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay {
                    RoundedRectangle(cornerRadius: 8).stroke(borderColor(model.uiState), lineWidth: 1)
                }
            }
        }
    }
}

extension InvoiceScreen.MoneyInputSection {
    
    fileprivate func borderColor(_ state: InvoiceScreen.UiState) -> Color {
        return switch state {
        case .failed: .red
        case .success(_, _): .primary70
        case .idle: .grey25
        }
    }
    
    fileprivate func contentBorderColor(_ state: InvoiceScreen.UiState) -> Color {
        return switch state {
        case .failed: .red.opacity(0.15)
        case .success(_, _): .primary15
        case .idle: .grey15
        }
    }
    
    fileprivate func containerColor(_ state: InvoiceScreen.UiState) -> Color {
        return switch state {
        case .failed: .red.opacity(0.05)
        case .success(_, _): .primary05
        case .idle: .grey05
        }
    }
    
}
