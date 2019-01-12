//
//  UnsplashPhotoList.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 05/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation
import ObjectMapper

struct UnsplashPhotoList: Mappable {
    
    var urls: UnsplashPhotoUrls?
    var authorInfo: UnsplashAuthorInfo?
    var width = CGFloat(0)
    var height = CGFloat(0)
    var description = ""
    var likes = 0
    var imageId = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        urls <- map["urls"]
        authorInfo <- map["user"]
        width <- map["width"]
        height <- map["height"]
        description <- map["description"]
        likes <- map["likes"]
        imageId <- map["id"]
    }
    
}
