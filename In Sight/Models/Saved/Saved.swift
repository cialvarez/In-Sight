//
//  Saved.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 09/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation
import ObjectMapper

private let savedImagesKey = "SavedImages"

class Saved: Mappable {
    private static var savedItems = [Saved]()
    private var imageId = ""
    private(set) var photo: UnsplashPhotoList?
    var isSaved: Bool {
        return Saved.filterBy(imageId: imageId) != nil
    }
    required init?(map: Map) {}
    init(photo: UnsplashPhotoList) {
        self.imageId = photo.imageId
        self.photo = photo
    }
    func mapping(map: Map) {
        imageId <- map["id"]
        photo <- map["photo"]
    }
    func add() {
         Saved.add(saved: self)
    }
    func remove() {
         Saved.remove(imageId: self.imageId)
    }
}

extension Saved {
    static func allStoredData() -> [Saved] {
        savedItems.removeAll()
        if let savedDics = UserDefaults.standard.array(forKey: savedImagesKey) {
            savedDics.forEach {
                if let dic = $0 as? [String: Any],
                    let saved = Mapper<Saved>().map(JSON: dic) {
                    savedItems.append(saved)
                }
            }
        }
        return savedItems
    }
    static func filterBy(imageId: String) -> Saved? {
        let results = allStoredData().filter {
            return $0.imageId == imageId
        }
        return results.first
    }
    fileprivate static func add(saved: Saved) {
        savedItems.append(saved)
        save()
    }
    fileprivate static func remove(imageId: String) {
        if let result = filterBy(imageId: imageId) {
            if let index = savedItems.index(where: {
                return $0.imageId == result.imageId
            }) {
                savedItems.remove(at: index)
            }
        }
        save()
    }
    private static func save() {
        var dataToSave = [[String: Any]]()
        savedItems.forEach {
            dataToSave.append($0.toJSON())
        }
        UserDefaults.standard.set(dataToSave, forKey: savedImagesKey)
        UserDefaults.standard.synchronize()
    }
}
