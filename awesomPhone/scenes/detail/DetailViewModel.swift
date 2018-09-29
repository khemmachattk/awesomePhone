//
//  DetailViewModel.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 30/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import Foundation

class DetailViewModel {
    let phone: PhoneModel?
    
    init(phoneId: Int) {
        phone = PhoneDataAccessObject.shared.fetchPhone(id: phoneId)
    }
}
