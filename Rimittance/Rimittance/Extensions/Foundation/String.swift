//
//  String.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import Foundation


extension String {
    
    var localized: String {
        get { return NSLocalizedString(self, comment: "") }
    }
    
    func decode<T: Decodable>(_ type : T.Type) -> T? {
        do {
            return try? JSONDecoder().decode(type, from: Data(self.utf8))
        } catch {
            print("couldn't parse json!")
            return nil
        }
    }
}
