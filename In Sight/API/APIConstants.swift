//
//  APIConstants.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 6/1/20.
//  Copyright © 2020 Freelancer. All rights reserved.
//

import Foundation

enum APIConstants {
    static var unsplashBaseUrlString: String = {
        #if DEBUG
        return "https://api.unsplash.com"
        #else
        return "https://api.unsplash.com"
        #endif
    }()
}
