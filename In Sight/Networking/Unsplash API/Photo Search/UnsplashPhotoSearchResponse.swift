//
//  UnsplashPhotoSearchResponse.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 09/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation

import ObjectMapper

struct UnsplashPhotoSearchResponse: Mappable {
    var results = [UnsplashPhotoList]()
    var total = 0
    init?(map: Map) {
        mapping(map: map)
    }
    mutating func mapping(map: Map) {
        results <- map["results"]
        total <- map["total"]
    }
}
