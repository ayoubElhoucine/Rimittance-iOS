//
//  RimittanceApp.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import SwiftUI

@main
struct RimittanceApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
        }
    }
}
