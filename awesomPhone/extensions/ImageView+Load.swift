//
//  ImageView+Load.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 29/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(_ path: String?) {
        guard let path = path else {
            return
        }
        
        kf.setImage(with: URL(string: path))
    }
}
