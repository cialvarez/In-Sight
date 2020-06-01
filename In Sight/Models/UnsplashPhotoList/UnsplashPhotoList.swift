//
//  UnsplashPhotoList.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 05/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation
import UIKit

struct UnsplashPhotoList: Codable {
    var urls: UnsplashPhotoUrls?
    var user: UnsplashAuthorInfo?
    var width = CGFloat(0)
    var height = CGFloat(0)
    var description: String?
    var likes = 0
    var id = ""
}
