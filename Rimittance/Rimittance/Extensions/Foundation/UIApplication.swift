//
//  UIApplication.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 3/2/2024.
//

import Foundation
import UIKit


extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
