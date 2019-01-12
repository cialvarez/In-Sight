//
//  UnsplashRequestBaseDefault.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 06/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation

class UnsplashRequestBaseDefault: RequestBaseDefault {
    
    override var queryParameters: [String: String] {
        return [:]
    }
    
    override var customHeaders: [String: String] {
        #if DEBUG
        return ["Accept-Version":"v1",
                "Authorization":"Client-ID 1582001f3b343e73ba9acdc49eedc15f8949c654d36352ba6a8bf6adee0d2c32"
        ]
        #else
        return [:]
        #endif
    }
}

