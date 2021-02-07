//
//  CMoneyViewModel.swift
//  CMonyTest
//
//  Created by 季紅 on 2021/2/2.
//  Copyright © 2021 johnlin. All rights reserved.
//

import Foundation

class CMoneyViewModel {
    var data = Bindable<[CMoneyModel]>()
    func fetchData() {
        NetworkManager.shared.request(CMoneyAPI.getData, model: [CMoneyModel].self) { (result) in
            switch result {
            case .success(let content):
                self.data.value = content
            case .fail(let error):
                print(error)
            }
        }
    }
}
