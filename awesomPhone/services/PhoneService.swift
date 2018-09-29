//
//  PhoneService.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 29/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class PhoneService {
    typealias FetchAllPhonesCompletion = ([PhoneModel]?, ResponseError?) -> Void
    typealias FetchPhoneImages = ([PhoneImageModel]?, ResponseError?) -> Void
    
    static let shared = PhoneService()
    
    private init() {}
}

// MARK: -
extension PhoneService {
    func fetchAllPhones(completion: @escaping FetchAllPhonesCompletion) {
        Alamofire.request(PhoneRouter.allPhones).responseJSON { response in
            if (!response.result.isSuccess) {
                completion(nil, ResponseError(message: "Server error"))
            }
            
            guard let value = response.value as? [[String: Any]] else {
                completion(nil, ResponseError(message: "Response null"))
                return
            }
            
            do {
                let phones = try Mapper<PhoneModel>().mapArray(JSONArray: value)
                completion(phones, nil)
            } catch {
                completion(nil, ResponseError(message: "Parse json error"))
            }
        }
    }
    
    func fetchPhoneImages(id: Int, completion: @escaping FetchPhoneImages) {
        Alamofire.request(PhoneRouter.phoneImages(id: id)).responseJSON { response in
            if (!response.result.isSuccess) {
                completion(nil, ResponseError(message: "Server error"))
            }
            
            guard let value = response.value as? [[String: Any]] else {
                completion(nil, ResponseError(message: "Response null"))
                return
            }
            
            do {
                let images = try Mapper<PhoneImageModel>().mapArray(JSONArray: value)
                completion(images, nil)
            } catch {
                completion(nil, ResponseError(message: "Parse json error"))
            }
        }
    }
}
