//
//  SecondViewController.swift
//  CMonyTest
//
//  Created by 季紅 on 2021/2/2.
//  Copyright © 2021 johnlin. All rights reserved.
//

import UIKit

class SecondViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var data: [CMoneyModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    override func setupUI() {
        collectionView.register(cellType: SecondCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func fetchData() {
        NetworkManager.shared.request(CMoneyAPI.getData, model: [CMoneyModel].self) { (result) in
            switch result {
            case .success(let content):
                self.data = content
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .fail(let error):
                print(error)
            }
        }
    }
}

extension SecondViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: SecondCollectionViewCell.self, for: indexPath)
        let info = self.data[indexPath.row]
        cell.configCell(viewData: SecondViewData(title: info.title, imageUrl: info.url))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let info = self.data[indexPath.row]
        let vc = InfoViewController(info: info)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SecondViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSpace: CGFloat = 5
        let leftRightMargin: CGFloat = 10
        let numColumns: CGFloat = 4
        
        let totalCellSpace = cellSpace * (numColumns - 1)
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth - leftRightMargin - totalCellSpace) / numColumns
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
