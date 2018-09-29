//
//  UIViewController+Alert.swift
//  nockacademy
//
//  Created by Khemmachat Thongkhum on 3/26/2561 BE.
//  Copyright © 2561 Liclass. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            completion?()
        }))
        
        present(alert, animated: true, completion: nil)
    }
}
