//
//  ImageCarouselCollectionViewCell.swift
//  workguru
//
//  Created by Khemmachat Thongkhum on 12/11/2560 BE.
//  Copyright © 2560 Khemmachat Thongkhum. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCarouselCollectionViewCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Configure
extension ImageCarouselCollectionViewCell {
    func configure(url: String) {
        photoImageView.load(url)
    }
}
