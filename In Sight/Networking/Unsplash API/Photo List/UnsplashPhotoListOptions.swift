//
//  UnsplashPhotoListOptions.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 05/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation

struct UnsplashPhotoListOptions {
    var page = 1
    var perPage = 20
    var orderBy = SortType.popular
}

// MARK: Request Parameter Base
extension UnsplashPhotoListOptions: RequestParameterBase {
    var queryParameters: [String: String] {
        var parameters = [String: String]()
        
        parameters["page"] = "\(page)"
        parameters["per_page"] = "\(perPage)"
        parameters["order_by"] = orderBy.rawValue

        return parameters
    }
}
