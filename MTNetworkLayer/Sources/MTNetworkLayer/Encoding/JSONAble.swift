//
//  JSONAble.swift
//  
//
//  Created by Murilo Teixeira on 04/11/21.
//

import Foundation

protocol JSONAble { }

extension JSONAble {
    func toDict() -> [String:Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
}
