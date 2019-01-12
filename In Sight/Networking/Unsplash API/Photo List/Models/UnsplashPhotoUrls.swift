//
//  UnsplashPhotoUrls.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 07/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation
import ObjectMapper
struct UnsplashPhotoUrls: Mappable {
    
    var full: URL?
    var regular: URL?
    var thumb: URL?
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        full <- (map["full"], URLTransform())
        regular <- (map["regular"], URLTransform())
        thumb <- (map["thumb"], URLTransform())
    }
    
    
}
