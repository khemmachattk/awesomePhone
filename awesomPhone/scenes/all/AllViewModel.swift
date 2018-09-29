//
//  AllViewModel.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 29/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import Foundation

struct AllViewModel {
    var items: [BaseCellItem] = []
}

// MARK: - Update view model
extension AllViewModel {
    mutating func updateItems(_ phones: [PhoneModel]) {
        items = phones.map { phone in
            PhoneTableViewCell.CellItem(
                identifier: "\(phone.id)",
                thumbnailUrl: phone.thumbImageURL,
                title: phone.name,
                description: phone.description,
                price: phone.price,
                rating: phone.rating,
                isFavorite: false)
        }
    }
}

// MARK: - Service
extension AllViewModel {
    mutating func fetchAllPhones(completion: @escaping PhoneService.FetchAllPhonesCompletion) {
        PhoneService.shared.fetchAllPhones(completion: completion)
    }
}

