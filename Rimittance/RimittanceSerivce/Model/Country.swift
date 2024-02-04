//
//  Country.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import Foundation


struct Country: Codable, Hashable {
    let id: String
    let name: String
    let currencyCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case currencyCode = "currency_code"
    }
}

extension Country {
    
    var iso: String {
        get {
            return switch(name) {
            case "Benin": "BJ"
            case "Morocco": "MA"
            case "Togo": "TG"
            case "Senegal": "SN"
            default: ""
            }
        }
    }
    
    var code: String {
        get {
            return switch(name) {
            case "Benin": "229"
            case "Morocco": "212"
            case "Togo": "228"
            case "Senegal": "221"
            default: ""
            }
        }
    }
    
}
