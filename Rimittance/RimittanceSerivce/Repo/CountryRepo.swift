//
//  CountryRepo.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import Foundation
import Combine
import Alamofire


protocol CountryRepoProtocol {
    func fetchCountries() -> AnyPublisher<DataResponse<[Country], Network.ErrorResponse>, Never>?
}

class CountryRepo: Network, CountryRepoProtocol {
    
    func fetchCountries() -> AnyPublisher<Alamofire.DataResponse<[Country], Network.ErrorResponse>, Never>? {
        get(url: Urls.countries.rawValue)
    }
    
}

extension CountryRepo {
    fileprivate enum Urls: String {
        case countries = "countries"
    }
}

extension CountryRepo {
    private static var sharedInstance: CountryRepo?
    
    class var shared: CountryRepo {
        guard let sharedInstance else {
            let instance = CountryRepo()
            sharedInstance = instance
            return sharedInstance ?? .init()
        }
        return sharedInstance
    }
    
    class func destroy() {
        sharedInstance = nil
    }
}
