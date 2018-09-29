//
//  PhoneRouter.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 29/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import Foundation
import Alamofire

enum PhoneRouter {
    case allPhones
    case phoneImages(id: Int)
}

extension PhoneRouter: Routable {
    var path: String {
        switch self {
        case .allPhones:
            return "/mobiles"
        case .phoneImages(let id):
            return "/mobiles/\(id)/images"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        return nil
    }
}
