//
//  Recipient.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import Foundation

struct Recipient: Decodable, Hashable {
    let id: String
    let name: String
    let country: String?
    let mobileWallet: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case country = "country"
        case mobileWallet = "mobile_wallet"
    }
}
