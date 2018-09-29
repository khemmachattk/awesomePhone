//
//  PhoneTableViewCell.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 29/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import UIKit

class PhoneTableViewCell: UITableViewCell, NibLoadable {
    typealias FavoriteHandler = (PhoneTableViewCell) -> Void
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    private var favoriteHandler: FavoriteHandler?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
}

// MARK: - Configure
extension PhoneTableViewCell {
    func configure(item: CellItem, favoriteHandler: FavoriteHandler? = nil) {
        self.favoriteHandler = favoriteHandler
        
        thumbnailImageView.load(item.thumbnailUrl)
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        priceLabel.text = "Price: $\(item.price.shortForm())"
        ratingLabel.text = "Rating: \(item.rating.shortForm())"
        favoriteImageView.isHidden = item.isFavorite == nil
        favoriteImageView.fillColor(with: item.isFavorite == true ? .blue : .lightGray)
    }
}

// MARK: - Action
private extension PhoneTableViewCell {
    @IBAction func favorite(_ sender: Any) {
        favoriteHandler?(self)
    }
}

// MARK: - Cell item
extension PhoneTableViewCell {
    struct CellItem: BaseCellItem {
        var cellIdentifier: String {
            return defaultReuseIdentifier
        }
        let identifier: String
        let thumbnailUrl: String
        let title: String
        let description: String
        let price: Double
        let rating: Double
        var isFavorite: Bool?
    }
}
