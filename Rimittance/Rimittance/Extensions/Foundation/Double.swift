//
//  Double.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import Foundation


public extension Double {
    
    func nicer(_ round: Int = 2) -> String {
        if self > Double(Int(self)) {
            return String(format: "%.\(round)f", self)
        } else {
            return String(format: "%.1f", self)
        }
    }
    
}
