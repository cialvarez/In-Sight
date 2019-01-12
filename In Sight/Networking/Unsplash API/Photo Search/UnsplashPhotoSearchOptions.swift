//
//  UnsplashPhotoSearchOptions.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 09/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation

struct UnsplashPhotoSearchOptions {
    var page = 1
    var perPage = 20
    var query = ""
    
    init(query: String) {
        self.query = query
    }
}

// MARK: Request Parameter Base
extension UnsplashPhotoSearchOptions: RequestParameterBase {
    var queryParameters: [String: String] {
        var parameters = [String: String]()
        
        parameters["page"] = "\(page)"
        parameters["per_page"] = "\(perPage)"
        parameters["query"] = query
        
        return parameters
    }
}
