//
//  Text.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
extension Text {
    func font(_ color: Color, _ rimittanceFont: Font.RimittanceFont, _ size: CGFloat) -> Text {
        switch rimittanceFont {
        case .regular:
            return self
                .font(.custom(Font.RimittanceFont.regular.rawValue, size: size))
                .foregroundColor(color)
        case .medium:
            return self
                .font(.custom(Font.RimittanceFont.medium.rawValue, size: size))
                .foregroundColor(color)
        case .semiBold:
            return self
                .font(.custom(Font.RimittanceFont.semiBold.rawValue, size: size))
                .foregroundColor(color)
        case .bold:
            return self
                .font(.custom(Font.RimittanceFont.bold.rawValue, size: size))
                .foregroundColor(color)
        }
    }
}
