//
//  CoordinatorView.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import Foundation


import SwiftUI
import UIKit

public struct CoordinatorView: View {
    enum StartPoint {
        case splash
        case login
        case home
    }
    
    let coordinator = NavigationCoordinator.shared
                                          
    public var body: some View {
        ZStack {
            StackTrigger(coordinator)
        }
    }
}
