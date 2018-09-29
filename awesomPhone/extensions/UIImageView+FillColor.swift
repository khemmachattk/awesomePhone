//
//  UIImageView+FillColor.swift
//  nockacademy
//
//  Created by Khemmachat Thongkhum on 3/6/2561 BE.
//  Copyright © 2561 Liclass. All rights reserved.
//

import UIKit

extension UIImageView {
    func fillColor(with color: UIColor) {
        image = image?.withRenderingMode(.alwaysTemplate)
        tintColor = color
    }
}
