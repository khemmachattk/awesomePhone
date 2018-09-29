//
//  AllViewModel.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 29/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import Foundation

class AllViewModel {
    var items: [BaseCellItem] = []
}

// MARK: - Update view model
extension AllViewModel {
    func updateItems(_ phones: [PhoneModel]) {
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
    func fetchAllPhones(completion: @escaping PhoneService.FetchAllPhonesCompletion) {
        PhoneService.shared.fetchAllPhones(completion: completion)
    }
    
    func favorite(index: Int) {
        switch items[index] {
        case var item as PhoneTableViewCell.CellItem:
            item.isFavorite = !item.isFavorite
            items[index] = item
        default:
            break
        }
    }
}

