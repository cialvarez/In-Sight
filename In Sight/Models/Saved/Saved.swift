//
//  Saved.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 09/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation

private let savedImagesKey = "SavedImages"

struct Saved: Codable {
    private static var savedItems = [Saved]()
    private var id = ""
    private(set) var photo: UnsplashPhotoList?
    var isSaved: Bool {
        return Saved.filterBy(imageId: id) != nil
    }
    
    init(photo: UnsplashPhotoList) {
        self.id = photo.id
        self.photo = photo
    }
    
    func add() {
         Saved.add(saved: self)
    }
    func remove() {
         Saved.remove(imageId: self.id)
    }
}

extension Saved {
    static func allStoredData() -> [Saved] {
        savedItems.removeAll()
        if let savedDics = UserDefaults.standard.array(forKey: savedImagesKey) {
            savedDics.forEach {
                let decoder = JSONDecoder()
//                decoder
                if let dic = $0 as? [String: Any] {
                    
//                    let saved = Mapper<Saved>().map(JSON: dic) {
//                    savedItems.append(saved)
                }
            }
        }
        return savedItems
    }
    static func filterBy(imageId: String) -> Saved? {
        let results = allStoredData().filter {
            return $0.id == imageId
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
                return $0.id == result.id
            }) {
                savedItems.remove(at: index)
            }
        }
        save()
    }
    private static func save() {
        var dataToSave = [[String: Any]]()
        let jsonDecoder = JSONDecoder()
        for savedItem in savedItems {
            
//            dataToSave.append($0.toJSON())
        }

        UserDefaults.standard.set(dataToSave, forKey: savedImagesKey)
        UserDefaults.standard.synchronize()
    }
}
