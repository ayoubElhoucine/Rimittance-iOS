//
//  UiState.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 2/2/2024.
//

import Foundation


extension RecipientScreen {
    enum UiState<Model> {
        case loading
        case empty
        case success(Model)
        case failed(String?)

        public var data: Model? {
            if case let .success(a) = self {
                return a
            } else {
                return nil
            }
        }
    }
}
