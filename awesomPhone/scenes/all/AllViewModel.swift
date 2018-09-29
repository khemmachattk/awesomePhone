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
        items = phones
            .sorted(by: { (previous, next) in
                previous.id < next.id
            }).map { phone in
                PhoneTableViewCell.CellItem(
                    identifier: "\(phone.id)",
                    thumbnailUrl: phone.thumbImageURL,
                    title: phone.name,
                    description: phone.description,
                    price: phone.price,
                    rating: phone.rating,
                    isFavorite: phone.isFavorite)
        }
    }
}

// MARK: - Service
extension AllViewModel {
    func loadStorePhones() {
        let favoritePhones = PhoneDataAccessObject.shared.fetchPhones()
        
        updateItems(favoritePhones)
    }
    
    func fetchAllPhones(completion: @escaping PhoneService.FetchAllPhonesCompletion) {
        PhoneService.shared.fetchAllPhones(completion: completion)
    }
    
    func favorite(index: Int) {
        let phoneId = Int(items[index].identifier)!
        let phone = PhoneDataAccessObject.shared.fetchPhone(id: phoneId)!
        
        PhoneDataAccessObject.shared.favorite(!phone.isFavorite, phoneId: phone.id)
        
        loadStorePhones()
    }
}

