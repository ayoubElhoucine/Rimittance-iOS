//
//  RecipientRepo.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//

import Foundation


class RecipientRepo: NetworkService {
    
    static let shared = RecipientRepo()
    
    private enum Urls: String {
        case recipients = "recipients"
    }
    
    func getRecipients(success: @escaping ([Recipient]) -> Void, failed: @escaping (ErrorResponse?) -> Void) {
        get(url: Urls.recipients.rawValue, success: success, failed: failed)
    }
}
