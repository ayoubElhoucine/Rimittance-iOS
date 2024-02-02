//
//  HomeScreen.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var model = Model()
    
    var body: some View {
        ScreenLayout {
            EmptyView()
        } contentFactory: { insets in
            
        }
    }
}

#Preview {
    HomeScreen()
}
