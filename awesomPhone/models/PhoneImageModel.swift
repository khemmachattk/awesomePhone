//
//  PhoneImageModel.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 29/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import Foundation
import ObjectMapper

struct PhoneImageModel {
    let id: Int
    let url: String
}

// MARK: - Mappable
extension PhoneImageModel: ImmutableMappable {
    init(map: Map) throws {
        id = try map.value("id")
        url = try map.value("url")
    }
}
