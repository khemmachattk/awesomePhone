//
//  UIView+Subview.swift
//  SB Digital
//
//  Created by pattarapon tiewgham on 5/9/2560 BE.
//  Copyright © 2560 CodeApp. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviewWithAutoConstraintToFill(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = self.bounds
        
        addSubview(view)
        
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
