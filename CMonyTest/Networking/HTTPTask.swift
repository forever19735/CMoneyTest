//
//  HttpTask.swift
//  CMonyTest
//
//  Created by 季紅 on 2021/2/2.
//  Copyright © 2021 johnlin. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case requestPlain
    case requestParameters(bodyParameters: CustomParameters?, urlParameters: CustomParameters?)
    case requestParametersAndHeaders(bodyParameters: CustomParameters?, urlParameters: CustomParameters?, additionHeaders: HTTPHeaders?)
    case requestHeaders(additionHeaders: HTTPHeaders?)
}
