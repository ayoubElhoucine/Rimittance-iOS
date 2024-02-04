//
//  WalletRepo.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import Foundation
import Combine
import Alamofire


protocol WalletRepoProtocol {
    func fetchWallets() -> AnyPublisher<DataResponse<[Wallet], Network.ErrorResponse>, Never>
}

class WalletRepo: Network, WalletRepoProtocol{
    
    func fetchWallets() -> AnyPublisher<DataResponse<[Wallet], Network.ErrorResponse>, Never> {
        return get(url: Urls.wallets.rawValue)
    }
    
}

extension WalletRepo {
    fileprivate enum Urls: String {
        case wallets = "wallets"
    }
}

extension WalletRepo {
    private static var sharedInstance: WalletRepo?
    
    class var shared: WalletRepo {
        guard let sharedInstance else {
            let instance = WalletRepo()
            sharedInstance = instance
            return sharedInstance ?? .init()
        }
        return sharedInstance
    }
    
    class func destroy() {
        sharedInstance = nil
    }
}
