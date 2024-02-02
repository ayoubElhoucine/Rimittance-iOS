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
        return try? JSONDecoder().decode(type, from: Data(self.utf8))
    }
}

extension String {
    // get country flag with country code
    var flag: String {
        get {
            let base : UInt32 = 127397
            var flag = ""
            for v in self.unicodeScalars {
                flag.unicodeScalars.append(UnicodeScalar(base + v.value)!)
            }
            return flag
        }
    }
}
