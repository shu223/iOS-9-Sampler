//
//  FilterHelper.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 2015/08/21.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

struct Filter {
    static func names(available_iOS: Int, category: String?, exceptCategories: [String]? = nil) -> [String] {
        let names = CIFilter.filterNamesInCategory(category).filter { (name) -> Bool in
            guard let filter = CIFilter(name: name) else {fatalError()}
            
            if let exceptCategories = exceptCategories {
                for aCategory in filter.categories() where exceptCategories.contains(aCategory) == true {
                    return false
                }
            }
            
            if filter.available_iOS() == available_iOS {
                return true
            } else {
                return false
            }
        }
        return names
    }
}

extension CIFilter {
    
    func categories() -> [String] {
        guard let categories = attributes[kCIAttributeFilterCategories] as? [String] else {fatalError()}
        return categories
    }
    
    func available_iOS() -> Int {
        guard let versionStr = attributes[kCIAttributeFilterAvailable_iOS] as? String else {return 0}
        guard let versionInt = Int(versionStr) else {return 0}
        return versionInt
    }
    
    func categoriesDescription() -> String {
        var description = categories().description
        
        description = description.stringByReplacingOccurrencesOfString("(", withString: "")
        description = description.stringByReplacingOccurrencesOfString(")", withString: "")
        description = description.stringByReplacingOccurrencesOfString("\n", withString: "")
        description = description.stringByReplacingOccurrencesOfString("   ", withString: "")
        description = description.stringByReplacingOccurrencesOfString("CICategory", withString: "")
        
        return description
    }
}

