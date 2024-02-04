//
//  NetworkService.swift
//  Rimittance
//
//  Created by Elhoucine Ayoub on 1/2/2024.
//


import Foundation
import Combine
import Alamofire


class Network {
    
    private let timout: Double = 15
    
    func get<Model: Codable>(url: String, query: [String: Any]? = nil) -> AnyPublisher<DataResponse<Model, ErrorResponse>, Never> {
        debugPrint("http:url: \(base)\(url)")
        return AF.request("\(base)\(url)", method: .get, parameters: query, encoding: URLEncoding.queryString) { (urlRequest: inout URLRequest) in
            urlRequest.timeoutInterval = self.timout
        }
        .validate()
        .publishDecodable(type: Model.self)
        .map { response in
            debugPrint("http:res: \(response.debugDescription)")
            
            return response.mapError { error in
                return ErrorResponse(code: error.responseCode ?? 0, message: error.errorDescription ?? "something_went_wrong")
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func post<Model: Decodable>(url: String, body: [String: Any]) -> AnyPublisher<DataResponse<Model, ErrorResponse>, Never> {
        debugPrint("http:url: \(base)\(url)")
        debugPrint("http:body: \(body)")
        
        return AF.request("\(base)\(url)", method: .post, parameters: body, encoding: JSONEncodingWithoutEscapingSlashes.prettyPrinted){ (urlRequest: inout URLRequest) in
            urlRequest.timeoutInterval = self.timout
        }
        .validate()
        .publishDecodable(type: Model.self)
        .map { response in
            debugPrint("http:res: \(response.debugDescription)")
            
            return response.mapError { error in
                return ErrorResponse(code: error.responseCode ?? 0, message: error.errorDescription ?? "something_went_wrong")
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func patch<Model: Decodable>(url: String, body: [String: Any]) -> AnyPublisher<DataResponse<Model, ErrorResponse>, Never> {
        debugPrint("http:url: \(base)\(url)")
        debugPrint("http:body: \(body)")
        
        return AF.request("\(base)\(url)", method: .patch, parameters: body, encoding: JSONEncodingWithoutEscapingSlashes.prettyPrinted){ (urlRequest: inout URLRequest) in
            urlRequest.timeoutInterval = self.timout
        }
        .validate()
        .publishDecodable(type: Model.self)
        .map { response in
            debugPrint("http:res: \(response.debugDescription)")
            
            return response.mapError { error in
                return ErrorResponse(code: error.responseCode ?? 0, message: error.errorDescription ?? "something_went_wrong")
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func put<Model: Decodable>(url: String, body: [String: Any]) -> AnyPublisher<DataResponse<Model, ErrorResponse>, Never> {
        debugPrint("http:url: \(base)\(url)")
        debugPrint("http:body: \(String(describing: body))")

        return AF.request("\(base)\(url)", method: .put, parameters: body, encoding: JSONEncoding.default){ (urlRequest: inout URLRequest) in
            urlRequest.timeoutInterval = self.timout
        }
        .validate()
        .publishDecodable(type: Model.self)
        .map { response in
            debugPrint("http:res: \(response.debugDescription)")
            
            return response.mapError { error in
                return ErrorResponse(code: error.responseCode ?? 0, message: error.errorDescription ?? "something_went_wrong")
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
}


extension Network {
    
    struct EmptyBody: EmptyResponse, Decodable {
        public static func emptyValue() -> Network.EmptyBody {
            return EmptyBody()
        }
    }
    
    struct ErrorResponse: Decodable, Error {
        let code: Int
        let message: String
    }
    
}

extension Network {
    
    fileprivate var scema: String {
        get { return "https" }
    }
    fileprivate var host: String {
        get { return "my-json-server.typicode.com/MonecoHQ" }
    }
    fileprivate var base: String {
        get { return "\(scema)://\(host)/fake-api/" }
    }
    
}
