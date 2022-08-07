//
//  Entity.swift
//  UIKitCombineExample
//
//  Created by Kotaro Fukuo on 2022/08/06.
//

import Foundation

struct Body: Decodable {
    var current: Current
    
    enum CodingKeys: String, CodingKey {
        case current = "current"
    }
}


struct Current: Decodable {
    var condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case condition = "condition"
    }
}

struct Condition: Decodable {
    var text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
    }
}
