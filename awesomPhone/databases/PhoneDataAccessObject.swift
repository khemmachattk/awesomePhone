//
//  PhoneDataAccessObject.swift
//  awesomPhone
//
//  Created by Khemmachat Thongkhum on 30/9/2561 BE.
//  Copyright © 2561 Khemmachat Thongkhum. All rights reserved.
//

import UIKit
import CoreData

class PhoneDataAccessObject {
    static let shared = PhoneDataAccessObject()
    
    private var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    private var manageContext: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    private init() {}
}

// MARK: - 
extension PhoneDataAccessObject {
    func createOrUpdate(_ phones: [PhoneModel]) {
        phones.forEach { phone in
            if let currentPhoneEntity = fetchPhoneEntity(id: phone.id) {
                currentPhoneEntity.from(phone)
            } else {
                let phoneEntity = PhoneEntity(context: manageContext)
                phoneEntity.from(phone)
                phoneEntity.images = []
            }
        }
        
        try! manageContext.save()
    }
    
    func createOrUpdate(_ images: [PhoneImageModel], to phoneId: Int) {
        guard let currentPhoneEntity = fetchPhoneEntity(id: phoneId) else {
            return
        }
        
        currentPhoneEntity.images = []
        
        images.forEach { image in
            if let currentImageEntity = fetchPhoneImageEntity(id: image.id) {
                currentImageEntity.from(image)
                currentPhoneEntity.addToImages(currentImageEntity)
            } else {
                let imageEntity = PhoneImageEntity(context: manageContext)
                imageEntity.from(image)
                currentPhoneEntity.addToImages(imageEntity)
            }
        }
        
        try! manageContext.save()
    }
    
    func favorite(_ isFavorite: Bool, phoneId: Int) {
        guard let phoneEntity = fetchPhoneEntity(id: phoneId) else {
            return
        }
        
        phoneEntity.isFavorite = isFavorite
    }
    
    func fetchPhoneEntity(id: Int) -> PhoneEntity? {
        let request: NSFetchRequest = PhoneEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d", id)
        
        let result = try! manageContext.fetch(request)
        
        return result.first
    }
    
    func fetchPhoneImageEntity(id: Int) -> PhoneImageEntity? {
        let request: NSFetchRequest = PhoneImageEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d", Int16(id))
        
        let result = try! manageContext.fetch(request)
        
        return result.first
    }
    
    func fetchPhones(isFavorite: Bool) -> [PhoneModel] {
        let request: NSFetchRequest = PhoneEntity.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite = %d", isFavorite)
        
        let result = try! manageContext.fetch(request)
        
        return result.map { phoneEntity in
            phoneEntity.toModel()
        }
    }
    
    func fetchPhone(id: Int) -> PhoneModel? {
        guard let phoneEntity = fetchPhoneEntity(id: id) else {
            return nil
        }
        
        return phoneEntity.toModel()
    }
}

// MARK: - Extension from and to model
extension PhoneEntity {
    func from(_ phone: PhoneModel) {
        id = Int16(phone.id)
        thumbImageURL = phone.thumbImageURL
        price = phone.price
        name = phone.name
        descriptionText = phone.description
        brand = phone.brand
        rating = phone.rating
    }
    
    func toModel() -> PhoneModel {
        return PhoneModel(entity: self)
    }
}

// MARK: -
extension PhoneImageEntity {
    func from(_ image: PhoneImageModel) {
        id = Int16(image.id)
        url = image.url
    }
}

// MARK: - Entity
extension PhoneDataAccessObject {
    enum Entity: String {
        case phone = "PhoneEntity"
    }
}
