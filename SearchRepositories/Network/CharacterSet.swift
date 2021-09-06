//
//  CharacterSet.swift
//  MVVM_New
//
//  Created by Arshad Ali on 05/08/21.
//  Copyright © 2021 Abhilash Mathur. All rights reserved.
//

import Foundation

extension CharacterSet {
    static func BaseAPI_URLQueryAllowedCharacterSet() -> CharacterSet {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: generalDelimitersToEncode + subDelimitersToEncode)
        return allowedCharacterSet
    }
}

