//
//  Double+ShortForm.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 30/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import Foundation

extension Double {
    func shortForm() -> String {
        return "\(String(format: "%g", self))"
    }
}
