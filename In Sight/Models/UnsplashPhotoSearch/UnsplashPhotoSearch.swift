//
//  UnsplashPhotoSearch.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 6/1/20.
//  Copyright © 2020 Freelancer. All rights reserved.
//

import Foundation
import Moya
struct UnsplashPhotoSearchResponse: Codable {
    var results = [UnsplashPhotoList]()
    var total = 0
}
