//
//  PhoneModel.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 29/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import Foundation
import ObjectMapper

struct PhoneModel {
    let id: Int
    let thumbImageURL: String
    let price: Double
    let name: String
    let description: String
    let brand: String
    let rating: Double
    let imagePaths: [String]
    let isFavorite: Bool
    
    init(entity: PhoneEntity) {
        id = Int(entity.id)
        thumbImageURL = entity.thumbImageURL!
        price = entity.price
        name = entity.name!
        description = entity.descriptionText!
        brand = entity.brand!
        rating = entity.rating
        isFavorite = entity.isFavorite
        
        let imageEntities: [PhoneImageEntity] = entity.images?.allObjects as! [PhoneImageEntity]
        imagePaths = imageEntities.sorted(by: { (previous, next) in
            previous.id < next.id
        }).map { imageEntity in
            imageEntity.url!
        }
        
    }
}

// MARK: - Mappable
extension PhoneModel: ImmutableMappable {
    init(map: Map) throws {
        id = try map.value("id")
        thumbImageURL = try map.value("thumbImageURL")
        price = try map.value("price")
        name = try map.value("name")
        description = try map.value("description")
        brand = try map.value("brand")
        rating = try map.value("rating")
        imagePaths = []
        isFavorite = false
    }
}
