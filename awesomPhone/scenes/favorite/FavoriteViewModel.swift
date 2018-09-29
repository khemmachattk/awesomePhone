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
extension FavoriteViewModel {
    func fetchFavoritePhones() {
        let favoritePhones = PhoneDataAccessObject.shared.fetchPhones(isFavorite: true)
        
        updateItems(favoritePhones)
    }
}
