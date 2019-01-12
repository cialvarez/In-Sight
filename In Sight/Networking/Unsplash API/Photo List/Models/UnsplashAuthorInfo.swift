//
//  UnsplashAuthorInfo.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 10/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation
import ObjectMapper
struct UnsplashAuthorInfo: Mappable {
    var name = ""
    init?(map: Map) {
        mapping(map: map)
    }
    mutating func mapping(map: Map) {
       name <- map["name"]
    }
}
