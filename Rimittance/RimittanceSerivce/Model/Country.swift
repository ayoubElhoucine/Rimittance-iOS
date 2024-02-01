//
//  Country.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import Foundation


struct Country: Decodable {
    let id: String
    let name: String
    let currencyCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case currencyCode = "currency_code"
    }
}
