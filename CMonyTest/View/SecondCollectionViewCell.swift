//
//  SecondCollectionViewCell.swift
//  CMonyTest
//
//  Created by 季紅 on 2021/2/2.
//  Copyright © 2021 johnlin. All rights reserved.
//

import UIKit

struct SecondViewData {
    let title: String
    let imageUrl: String
}

class SecondCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var imageURL: String? {
        didSet {
            if let url = imageURL {
                imageView.image = UIImage(named: "icon_empty")
                imageView.loadImageUsingCache(withUrl: url, showLoading: true) { (image) in
                    if url == self.imageURL {
                        self.imageView.image = image
                    }
                }
            } else {
                self.imageView.image = nil
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configCell(viewData: SecondViewData) {
        titleLabel.text = viewData.title
        imageURL = viewData.imageUrl
    }
}
