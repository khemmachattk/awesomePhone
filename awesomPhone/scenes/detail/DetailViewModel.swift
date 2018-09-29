//
//  DetailViewModel.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 30/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import Foundation

class DetailViewModel {
    let phoneId: Int
    var phone: PhoneModel?
    
    init(phoneId: Int) {
        self.phoneId = phoneId
        phone = PhoneDataAccessObject.shared.fetchPhone(id: phoneId)
    }
}

// MARK: -
extension DetailViewModel {
    func fetchImages(completion: @escaping PhoneService.FetchPhoneImages) {
        PhoneService.shared.fetchPhoneImages(phoneId: phoneId, completion: completion)
    }
    
    func updateItem(_ phone: PhoneModel?) {
        self.phone = phone
    }
}
