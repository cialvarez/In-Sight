//
//  RequestParameterBase.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 06/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation

protocol RequestParameterBase {
    var queryParameters: [String: String] {get}
    var bodyParameters: [String: Any] {get}
}

extension RequestParameterBase {
    var queryParameters: [String: String] {
        return [String: String]()
    }
    var bodyParameters: [String: Any] {
        return [String: String]()
    }
}
