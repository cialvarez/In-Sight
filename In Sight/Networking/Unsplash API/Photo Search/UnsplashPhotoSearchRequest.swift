//
//  UnsplashPhotoSearchRequest.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 09/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation

class UnsplashPhotoSearchRequest: UnsplashRequestBaseDefault {
    var options: UnsplashPhotoSearchOptions
    override var urlPath: String? {
        return "search/photos"
    }
    override var queryParameters: [String: String] {
        return super.queryParameters + options.queryParameters
    }
    init(options: UnsplashPhotoSearchOptions) {
        self.options = options
    }
}
