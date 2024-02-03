//
//  InvoiceScreen.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import SwiftUI

struct InvoiceScreen: View {
    
    @StateObject private var model = Model()
    let recipient: Recipient
    
    @State private var totalToSpend: Double = 0.0
    @State private var recipientReceive: Double = 0.0
    
    var body: some View {
        ScreenLayout {
            HeaderView(title: "send_money".localized, didBack: popBack)
        } contentFactory: { insets in
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    MoneyInputSection(model: model)
                    FreeRimittanceSection()
                    FeesSection()
                }.padding(16)
            }.padding(insets)
        }
        .onReceive(model.$uiState) { value in
            switch value {
            case .success(let total, let receive):
                totalToSpend = total
                recipientReceive = receive
            default:
                totalToSpend = 0.0
                recipientReceive = 0.0
            }
        }
    }
    
    @ViewBuilder
    private func FreeRimittanceSection() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("yearly_free".localized).font(.grey100, .medium, 16)
            Text("yearly_free_msg".localized).font(.grey50, .regular, 14)
            Text("check_free_msg".localized).font(.blue100, .semiBold, 14)
        }
    }
    
    @ViewBuilder
    private func FeesSection() -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("fees_break".localized).font(.grey100, .medium, 16)
            FeeItem(title: "moneco_fees", value: model.getMonecoFees())
            FeeItem(title: "transfer_fees", value: 0.0)
            FeeItem(title: "conversion_rate", value: model.getConversionRate(), currency: "XOF")
            FeeItem(title: "you_spend_total", value: totalToSpend)
            Spacer().asDashed()
            HStack {
                Text("recipient_gets".localized).font(.grey50, .regular, 14)
                Spacer()
                Text("\(recipientReceive.nicer()) XOF").font(.grey100, .semiBold, 18)
            }
        }
    }
    
    @ViewBuilder
    private func FeeItem(title: String, value: Double, currency: String = "EUR") -> some View {
        HStack {
            Text(title.localized).font(.grey50, .regular, 14)
            Spacer()
            Text("\(value.nicer()) \(currency)").font(.grey100, .regular, 14)
        }
    }
}
