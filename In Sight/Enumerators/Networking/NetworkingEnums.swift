//
//  NetworkingEnums.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 05/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Alamofire

enum HttpProtocol: String {
    case https
    case http
}

protocol URLDomainProtocol {
    var domain: String {get}
}

enum URLDomain {
    case debug
    case release
    case customDebug(URLDomainProtocol)
    case customRelease(URLDomainProtocol)
}

