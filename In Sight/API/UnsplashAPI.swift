//
//  UnsplashAPI.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 6/1/20.
//  Copyright © 2020 Freelancer. All rights reserved.
//

import Foundation
import Moya

enum UnsplashAPI {
    case photoSearch(options: UnsplashPhotoSearchOptions)
    case photoList(options: UnsplashPhotoListOptions)
}

extension UnsplashAPI: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.unsplashBaseUrlString)!
    }

    var path: String {
        switch self {
        case .photoSearch:
            return "search/photos"
        case .photoList:
            return "photos"
        }
    }

    var method: Moya.Method {
        switch self {
        case .photoSearch,
             .photoList:
            return .get
        }
    }
    
    var task: Task {
        var queryParameters = [String: Any]()
        var bodyParameters = [String: Any]()
        switch self {
        case let .photoSearch(options):
            queryParameters = options.queryParameters
            bodyParameters = options.bodyParameters
        case let .photoList(options):
            queryParameters = options.queryParameters
            bodyParameters = options.bodyParameters
        }
        return .requestParameters(parameters: queryParameters + bodyParameters, encoding: URLEncoding.queryString)
    }

    /// The headers to be used in the request.
    var headers: [String: String]? {
        #if DEBUG
        return ["Accept-Version": "v1",
                "Authorization": "Client-ID 1582001f3b343e73ba9acdc49eedc15f8949c654d36352ba6a8bf6adee0d2c32"
        ]
        #else
        return [:]
        #endif
    }
    
    var sampleData: Data {
        return Data()
    }
}
