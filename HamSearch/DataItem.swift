//
//  DataItem.swift
//  HamSearch
//
//  Created by Benjamin Faershtein on 2/4/24.
//

import Foundation
import SwiftData

@Model
class DataItem {
    var license: License
    
    init(license: License){
        self.license = license
    }
}
