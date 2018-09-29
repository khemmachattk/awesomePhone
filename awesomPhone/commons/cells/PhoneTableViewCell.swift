//
//  PhoneTableViewCell.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 29/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import UIKit

class PhoneTableViewCell: UITableViewCell, NibLoadable {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Configure
extension PhoneTableViewCell {
    func configure(item: CellItem) {
        
    }
}

// MARK: - Cell item
extension PhoneTableViewCell {
    struct CellItem: BaseCellItem {
        var cellIdentifier: String {
            return defaultReuseIdentifier
        }
        var identifier: String
    }
}
