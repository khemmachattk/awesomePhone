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
    typealias FetchPhoneImages = (PhoneModel?, ResponseError?) -> Void
    
    static let shared = PhoneService()
    
    private init() {}
}

// MARK: -
extension PhoneService {
    func fetchAllPhones(completion: @escaping FetchAllPhonesCompletion) {
        let storePhones = PhoneDataAccessObject.shared.fetchPhones(isFavorite: false)
        
        if (!storePhones.isEmpty) {
            completion(storePhones, nil)
        }
        
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

                completion(PhoneDataAccessObject.shared.createOrUpdate(phones), nil)
            } catch {
                completion(nil, ResponseError(message: "Parse json error"))
            }
        }
    }
    
    func fetchPhoneImages(phoneId: Int, completion: @escaping FetchPhoneImages) {
        let storePhone = PhoneDataAccessObject.shared.fetchPhone(id: phoneId)
        
        if let storePhone = storePhone {
            completion(storePhone, nil)
        }
        
        Alamofire.request(PhoneRouter.phoneImages(id: phoneId)).responseJSON { response in
            if (!response.result.isSuccess) {
                completion(nil, ResponseError(message: "Server error"))
            }
            
            guard let value = response.value as? [[String: Any]] else {
                completion(nil, ResponseError(message: "Response null"))
                return
            }
            
            do {
                let images = try Mapper<PhoneImageModel>().mapArray(JSONArray: value)
                
                completion(PhoneDataAccessObject.shared.createOrUpdate(images, to: phoneId), nil)
            } catch {
                completion(nil, ResponseError(message: "Parse json error"))
            }
        }
    }
}
