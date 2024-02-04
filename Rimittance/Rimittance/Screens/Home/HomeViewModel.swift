//
//  HomeScreenModel.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 2/2/2024.
//

import Foundation
import Combine


extension HomeScreen {
    class ViewModel: ObservableObject {
        
        private var cancellables: Set<AnyCancellable> = []
        
        deinit {
            cancellables.removeAll()
        }
        
    }
}
