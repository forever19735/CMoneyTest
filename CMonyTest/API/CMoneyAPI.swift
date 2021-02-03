//
//  CMoneyAPI.swift
//  CMonyTest
//
//  Created by 季紅 on 2021/2/2.
//  Copyright © 2021 johnlin. All rights reserved.
//

import Foundation

enum CMoneyAPI {
    case getData
}

extension CMoneyAPI: EndPointType {
   var task: HTTPTask {
       return .requestPlain
   }
   
   var parameters: CustomParameters? {
       return nil
   }
   
   var headers: HTTPHeaders? {
       return nil
   }
   
   var baseURL: URL {
       guard let url = URL(string: "https://raw.githubusercontent.com") else {
           fatalError("baseURL could not be configured.")
       }
       return url
   }
   
   var path: String {
       switch self {
       case .getData:
           return "/cmmobile/NasaDataSet/main/apod.json"
       }
   }
   
   var httpMethod: HTTPMethod {
       return .get
   }
}
