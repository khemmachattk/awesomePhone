//
//  FavoriteViewModel.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 29/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import Foundation

class FavoriteViewModel {
    var items: [BaseCellItem] = []
}

// MARK: - Update view model
extension FavoriteViewModel {
    func updateItems(_ phones: [PhoneModel]) {
        items = phones.map { phone in
                PhoneTableViewCell.CellItem(
                    identifier: "\(phone.id)",
                    thumbnailUrl: phone.thumbImageURL,
                    title: phone.name,
                    description: phone.description,
                    price: phone.price,
                    rating: phone.rating,
                    isFavorite: nil)
        }
    }
}

// MARK: - Service
extension FavoriteViewModel {
    func loadStoreFavoritePhones() {
        let favoritePhones = PhoneDataAccessObject.shared.fetchPhones(isFavorite: true)
        
        updateItems(favoritePhones)
    }
    
    func unFavorite(index: Int) {
        let phoneId = Int(items[index].identifier)!
        let phone = PhoneDataAccessObject.shared.fetchPhone(id: phoneId)!
        
        PhoneDataAccessObject.shared.favorite(false, phoneId: phone.id)
        
        loadStoreFavoritePhones()
    }
    
    func sort(type: SortType) {
        PhoneDataAccessObject.shared.changeSort(type)
        
        loadStoreFavoritePhones()
    }
}
