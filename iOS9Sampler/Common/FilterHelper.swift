//
//  FilterHelper.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 2015/08/21.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit


class FilterHelper: NSObject {

    class func filterNamesFor_iOS9(category: String?, exceptCategories: [String]? = nil) -> [String]! {
        
        var filterNames:[String] = []
        let all = CIFilter.filterNamesInCategory(category)
        
        for aFilterName in all {
            
            let attributes = CIFilter(name: aFilterName)!.attributes
            if let exceptCategories = exceptCategories {
                var needExcept = false
                let categories = attributes[kCIAttributeFilterCategories] as! [String]
                for aCategory in categories where exceptCategories.contains(aCategory) == true {
                    needExcept = true
                    break
                }
                if needExcept {
                    continue
                }
            }
            
            let availability = attributes[kCIAttributeFilterAvailable_iOS]
//            print("filtername:\(aFilterName), availability:\(availability)")            
            if let availability = availability as? String where availability == "9" {
                filterNames.append(aFilterName)
            }
        }
        return filterNames
    }
    
}

extension CIFilter {
    
    func categoriesStringForFilter() -> String {
        guard let categories = attributes[kCIAttributeFilterCategories] as? [String] else {fatalError()}
        var description = categories.description
        
        description = description.stringByReplacingOccurrencesOfString("(", withString: "")
        description = description.stringByReplacingOccurrencesOfString(")", withString: "")
        description = description.stringByReplacingOccurrencesOfString("\n", withString: "")
        description = description.stringByReplacingOccurrencesOfString("   ", withString: "")
        description = description.stringByReplacingOccurrencesOfString("CICategory", withString: "")
        
        return description
    }
}

