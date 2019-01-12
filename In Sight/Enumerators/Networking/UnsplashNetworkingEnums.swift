//
//  UnsplashNetworkingEnums.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 05/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation

extension URLDomain: URLDomainProtocol {
    var domain: String {
        switch self {
        case .debug:
            return "api.unsplash.com"
        case .release:
            return "api.unsplash.com"
        case .customDebug(let custom):
            return custom.domain
        case .customRelease(let custom):
            return custom.domain
        }
    }
}
