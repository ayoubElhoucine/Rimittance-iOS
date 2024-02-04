//
//  InvoiceScreenModel.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 3/2/2024.
//

import Foundation


extension InvoiceScreen {
    class ViewModel: ObservableObject {
        
        @Published private(set) var uiState: UiState = .idle
        
        private let conversionRate = 655.94/1
        private let monecoFees = 1.0
        private let balance = 230.0
                
        func calculate(value: String) {
            if let value = Double(value) {
                if value == 0.0 {
                    uiState = .idle
                } else if value > 0.0 && value + monecoFees <= balance {
                    uiState = .success(value + monecoFees, value * conversionRate)
                } else if value + monecoFees > balance || value < 0.0 {
                    uiState = .failed
                }
            } else {
                uiState = .idle
            }
        }
        
        func getMonecoFees() -> Double {
            return monecoFees
        }
        
        func getConversionRate() -> Double {
            return conversionRate
        }
    }
}
