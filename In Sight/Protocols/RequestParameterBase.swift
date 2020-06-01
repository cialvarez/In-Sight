//
//  RequestParameterBase.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 06/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation

protocol RequestParameterBase {
    var queryParameters: [String: Any] {get}
    var bodyParameters: [String: Any] {get}
}

extension RequestParameterBase {
    var queryParameters: [String: Any] {
        return [String: Any]()
    }
    var bodyParameters: [String: Any] {
        return [String: String]()
    }
}
