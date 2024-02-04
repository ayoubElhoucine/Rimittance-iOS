//
//  RecipientRepo.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import Foundation
import Combine
import Alamofire


protocol RecipientRepoProtocol {
    func fetchRecipients() -> AnyPublisher<DataResponse<[Recipient], Network.ErrorResponse>, Never>?
}

class RecipientRepo: Network, RecipientRepoProtocol {
        
    func fetchRecipients() -> AnyPublisher<Alamofire.DataResponse<[Recipient], Network.ErrorResponse>, Never>? {
        return get(url: Urls.recipients.rawValue)
    }

}

extension RecipientRepo {
    fileprivate enum Urls: String {
        case recipients = "recipients"
    }
}

extension RecipientRepo {
    private static var sharedInstance: RecipientRepo?
    
    class var shared: RecipientRepo {
        guard let sharedInstance else {
            let instance = RecipientRepo()
            sharedInstance = instance
            return sharedInstance ?? .init()
        }
        return sharedInstance
    }
    
    class func destroy() {
        sharedInstance = nil
    }
}
