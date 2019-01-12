//
//  UnsplashPhotoListRequest.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 05/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation

class UnsplashPhotoListRequest: UnsplashRequestBaseDefault {
    var options: UnsplashPhotoListOptions
    
    override var urlPath: String? {        
        return "photos"
    }
    
    override var queryParameters: [String: String] {
        return super.queryParameters + options.queryParameters
    }
    
    init(options: UnsplashPhotoListOptions) {
        self.options = options
    }
}
