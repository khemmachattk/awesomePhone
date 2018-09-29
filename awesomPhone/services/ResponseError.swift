//
//  ResponseError.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 29/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import Foundation

struct ResponseError: Error {
    let code: Int
    let message: String
    
    init(message: String) {
        code = 0
        self.message = message
    }
    
    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
}
