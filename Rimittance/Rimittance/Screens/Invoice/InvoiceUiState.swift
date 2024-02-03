//
//  InvoiceUiState.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 3/2/2024.
//

import Foundation


extension InvoiceScreen {
    enum UiState {
        case idle
        case success(Double, Double)
        case failed
        
        var data: (total: Double, receive: Double) {
            switch self {
            case .success(let total, let receive): return (total, receive)
            default: return (0.0, 0.0)
            }
        }
    }
}
