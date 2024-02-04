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
    
    private let session = Session()
    
    private let timout: Double = 15
    
    private let base: String = "https://my-json-server.typicode.com/MonecoHQ/fake-api/"
    
    
    func get<Model: Codable>(url: String, query: [String: Any]? = nil) -> AnyPublisher<DataResponse<Model, ErrorResponse>, Never>? {
        if let url = URL(string: "\(base)\(url)") {
            debugPrint("http:url: \(url.absoluteString)")
            return AF.request(url, method: .get, parameters: query, encoding: URLEncoding.queryString) { (urlRequest: inout URLRequest) in
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
        } else {
            return nil
        }
    }
    
    func post<Model: Decodable>(url: String, body: [String: Any], success: @escaping (Model) -> Void, failed: @escaping (ErrorResponse?) -> Void){
        debugPrint("http:url: \(base)\(url)")
        debugPrint("http:body: \(body)")
        
        AF.request("\(base)\(url)", method: .post, parameters: body, encoding: JSONEncodingWithoutEscapingSlashes.prettyPrinted){ (urlRequest: inout URLRequest) in
            urlRequest.timeoutInterval = self.timout
        }.responseDecodable(emptyResponseCodes: [200]) { (response: DataResponse<Model, AFError>) in
            
            debugPrint("http:res: \(response.debugDescription)")
            
            guard let status = response.response?.statusCode else {
                failed(ErrorResponse(code: 0, message: "somthing_went_wrong".localized))
                return
            }
            
            switch status {
            case 200...299:
                switch response.result {
                case .success(let res):
                    success(res)
                case .failure(let error):
                    failed(ErrorResponse(code: error.responseCode ?? 0, message: error.errorDescription ?? ""))
                }
            case 400...499:
                guard let data = response.data, let error = try? JSONDecoder().decode(ErrorResponse.self, from: data) else {
                    failed(ErrorResponse(code: 0, message: "somthing_went_wrong".localized))
                    return
                }
                failed(error)
            default: failed(ErrorResponse(code: 0, message: "somthing_went_wrong".localized))
            }
        }
    }
    
    func patch<Model: Decodable>(url: String, body: [String: Any], success: @escaping (Model) -> Void, failed: @escaping (ErrorResponse?) -> Void){
        debugPrint("http:url: \(base)\(url)")
        debugPrint("http:body: \(body)")
        
        AF.request("\(base)\(url)", method: .patch, parameters: body, encoding: JSONEncodingWithoutEscapingSlashes.prettyPrinted){ (urlRequest: inout URLRequest) in
            urlRequest.timeoutInterval = self.timout
        }.responseDecodable(of: Model.self, emptyResponseCodes: [200]) { response in
            
            debugPrint("http:res: \(response.debugDescription)")
            
            guard let status = response.response?.statusCode else {
                failed(ErrorResponse(code: 0, message: "somthing_went_wrong".localized))
                return
            }
            
            switch status {
            case 200...299:
                switch response.result {
                case .success(let res):
                    success(res)
                case .failure(let error):
                    failed(ErrorResponse(code: 0, message: error.errorDescription ?? ""))
                }
            case 400...499:
                guard let data = response.data, let error = try? JSONDecoder().decode(ErrorResponse.self, from: data) else {
                    failed(ErrorResponse(code: 0, message: "somthing_went_wrong".localized))
                    return
                }
                failed(error)
            default: failed(ErrorResponse(code: 0, message: "somthing_went_wrong".localized))
            }
        }
    }
    
    func put<Model: Decodable>(url: String, body: [String: Any]? = nil, success: @escaping (Model?) -> Void, failed: @escaping (ErrorResponse?) -> Void){
        debugPrint("http:url: \(base)\(url)")
        debugPrint("http:body: \(String(describing: body))")

        AF.request("\(base)\(url)", method: .put, parameters: body, encoding: JSONEncoding.default){ (urlRequest: inout URLRequest) in
            urlRequest.timeoutInterval = self.timout
        }.responseDecodable(of: Model.self, emptyResponseCodes: [200]) { response in
            debugPrint("http:res: \(response.debugDescription)")
            
            guard let status = response.response?.statusCode else {
                failed(ErrorResponse(code: 0, message: "somthing_went_wrong".localized))
                return
            }
            
            switch status {
            case 200...299:
                switch response.result {
                case .success(let res):
                    success(res)
                case .failure(let error):
                    failed(ErrorResponse(code: 0, message: error.errorDescription ?? ""))
                }
            case 400...499:
                guard let data = response.data, let error = try? JSONDecoder().decode(ErrorResponse.self, from: data) else {
                    failed(ErrorResponse(code: 0, message: "somthing_went_wrong".localized))
                    return
                }
                failed(error)
            default: failed(ErrorResponse(code: 0, message: "somthing_went_wrong".localized))
            }
        }
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
