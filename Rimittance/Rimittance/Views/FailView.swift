//
//  FailView.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 2/2/2024.
//

import SwiftUI

struct FailView: View {
    private let action: (() -> Void)?
    
    init(action: ( () -> Void)? = nil) {
        self.action = action
    }
    
    var body: some View {
        VStack {
            Spacer()
            Image("ic_close")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.red)
                .frame(width: 35, height: 35)
                .background(Circle().stroke(.white, lineWidth: 20).padding(10))
                .padding(.bottom)
            
            HStack {
                Text("something_went_wrong".localized)
                    .font(.grey100, .regular, 14)
                if let action = self.action {
                    Button(action: action) {
                        Text("retry".localized)
                            .font(.grey100, .semiBold, 14)
                            .underline(true, color: .grey100)
                    }
                }
            }
            Spacer()
        }.padding(.horizontal, 16)
    }
}
