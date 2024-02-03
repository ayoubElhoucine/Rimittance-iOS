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
    }
}
