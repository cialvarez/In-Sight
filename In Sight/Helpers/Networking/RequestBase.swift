//
//  RequestBase.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 05/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestBase: URLRequestConvertible {
    var httpProtocol: HttpProtocol { get }
    var httpMethod: HTTPMethod { get }
    var urlDomain: URLDomain? { get }
    var urlPath: String? { get }
    var url: String { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var queryParameters: [String: String] {get}
    var bodyParameters: [String: Any] {get}
    var customHeaders: [String: String] { get }
}

extension RequestBase {
    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        // set http protocol
        urlComponents.scheme = httpProtocol.rawValue
        // set domain
        if let urlDomain = urlDomain {
            urlComponents.host = urlDomain.domain
        }
        // set Path
        if !url.isEmpty {
            urlComponents.path = url
        }
        // create requet from url components
        var urlRequest = URLRequest(url: urlComponents.url!)
        if !queryParameters.isEmpty {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: queryParameters)
        }
        // set http body
        if !bodyParameters.isEmpty {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: bodyParameters)
        }
        // set custom request headers
        customHeaders.forEach {
            urlRequest.setValue($1, forHTTPHeaderField: $0)
        }
        // set http method
        urlRequest.httpMethod = httpMethod.rawValue
        // set cache policy
        urlRequest.cachePolicy = cachePolicy
        print("[ Request URL ] = \(urlRequest.url?.absoluteString ?? "")")
        print("[ Request Body ] = \(String(describing: urlRequest.httpBody))")
        print("[ Request Header ] = \(String(describing: urlRequest.allHTTPHeaderFields))")
        return urlRequest
    }
}
