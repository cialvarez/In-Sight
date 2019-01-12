//
//  Dictionary+Operators.swift
//  In Sight
//
//  Created by Christian Iñigo De Leon Alvarez on 06/01/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation

extension Dictionary {
    
    static func + (left: Dictionary, right: Dictionary) -> Dictionary {
        
        var map = Dictionary()
        for (key, val) in left {
            map[key] = val
        }
        for (key, val) in right {
            map[key] = val
        }
        return map
    }
    
}
