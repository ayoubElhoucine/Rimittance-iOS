//
//  CountryRepo.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import Foundation


class CountryRepo: NetworkService {
    
    static let shared = CountryRepo()
    
    private enum Urls: String {
        case countries = "countries"
    }
    
    func getCountries(success: @escaping ([Country]) -> Void, failed: @escaping (ErrorResponse?) -> Void) {
        get(url: Urls.countries.rawValue, success: success, failed: failed)
    }
}
