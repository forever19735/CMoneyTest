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
    
    let viewModel = CMoneyViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData()
        viewModel.data.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func setupUI() {
        collectionView.register(cellType: SecondCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension SecondViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: SecondCollectionViewCell.self, for: indexPath)
        guard let info = viewModel.data.value?[indexPath.row] else { return UICollectionViewCell() }
        cell.configCell(viewData: SecondViewData(title: info.title, imageUrl: info.url))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let info = viewModel.data.value?[indexPath.row] else { return }
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
