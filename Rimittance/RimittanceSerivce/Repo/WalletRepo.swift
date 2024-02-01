//
//  WalletRepo.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import Foundation


class WalletRepo: NetworkService {
    
    static let shared = WalletRepo()
    
    private enum Urls: String {
        case wallets = "wallets"
    }
    
    func getWallets(success: @escaping ([Wallet]) -> Void, failed: @escaping (ErrorResponse?) -> Void) {
        get(url: Urls.wallets.rawValue, success: success, failed: failed)
    }
}
