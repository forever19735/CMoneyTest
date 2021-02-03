//
//  InfoViewController.swift
//  CMonyTest
//
//  Created by 季紅 on 2021/2/2.
//  Copyright © 2021 johnlin. All rights reserved.
//

import UIKit

class InfoViewController: BaseViewController {
    var info: CMoneyModel
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var copyrightLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    init(info: CMoneyModel) {
        self.info = info
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        let date = info.date.convertToDate(format: "yyyy-MM-dd")?.convertToString(format: "yyyy MMM. d")
        dateLabel.text = date
        titleLabel.text = info.title
        descriptionLabel.text = info.description
        copyrightLabel.text = info.copyright
        imageView.loadImageUsingCache(withUrl: info.hdurl, showLoading: true) { (image) in
            self.imageView.image = image
        }
    }
}
