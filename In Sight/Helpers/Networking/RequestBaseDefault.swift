//
//  RequestBaseDefault.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 06/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation
import Alamofire

class RequestBaseDefault: RequestBase {
    var httpProtocol: HttpProtocol {
        return .https
    }
    var httpMethod: HTTPMethod {
        return .get
    }
    var urlDomain: URLDomain? {
        #if DEBUG
        return .debug
        #else
        return .release
        #endif
    }
    var urlPath: String? {
        return nil
    }
    var url: String {
        var url = "/"
        if let urlPath = urlPath {
            url += urlPath
        }
        return url
    }
    var cachePolicy: URLRequest.CachePolicy {
        return .useProtocolCachePolicy
    }
    var queryParameters: [String: String] {
        return [String: String]()
    }
    var bodyParameters: [String: Any] {
        return [String: Any]()
    }
    var customHeaders: [String: String] {
        return [String: String]()
    }
}
