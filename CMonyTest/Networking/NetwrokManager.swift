//
//  NetwrokManager.swift
//  CMonyTest
//
//  Created by 季紅 on 2021/2/2.
//  Copyright © 2021 johnlin. All rights reserved.
//

import Foundation

enum NetworkResponse: String {
    case success = "success"
    case authenticationError = "You need to be authenticated first"
    case badRequest = "Bad request"
    case failed = "Network request failed"
    case noData = "Response returned with no data to decode"
    case decodeFaield = "Decode Json Failed"
}

enum Result<T, NetworkError> {
    case success(T)
    case fail(NetworkError)
}
class NetworkManager {
    static let shared = NetworkManager()
}

extension NetworkManager {
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String, String> {
        switch response.statusCode {
        case 200...299:
            return .success(NetworkResponse.success.rawValue)
        case 401...500:
            return .fail(NetworkResponse.authenticationError.rawValue)
        case 501...599:
            return .fail(NetworkResponse.badRequest.rawValue)
        default:
            return .fail(NetworkResponse.failed.rawValue)
        }
    }

    func request<T: EndPointType, MO: Decodable>(_ target: T, model: MO.Type, completion:  ((Result<MO, String>)-> Void)?) {
        Router<T>().request(target) { (data, response , error) in
            if let response = response as? HTTPURLResponse {
                let reuslt = self.handleNetworkResponse(response)
                switch reuslt {
                case .success:
                    guard let responseData = data else {
                        completion?(.fail(NetworkResponse.failed.rawValue))
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(model.self, from: responseData)
                        completion?(.success(apiResponse))
                    } catch {
                        completion?(.fail(NetworkResponse.decodeFaield.rawValue))
                    }
                case .fail(let error):
                    completion?(.fail(error))
                }
            }
        }
    }
}
