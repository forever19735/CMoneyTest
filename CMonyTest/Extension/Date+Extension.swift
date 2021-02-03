//
//  Date+Extension.swift
//  CMonyTest
//
//  Created by 季紅 on 2021/2/3.
//  Copyright © 2021 johnlin. All rights reserved.
//

import Foundation

extension Date {
    func convertToString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
  
        return dateFormatter.string(from: self)
    }
}
