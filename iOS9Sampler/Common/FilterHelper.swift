//
//  FilterHelper.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 2015/08/21.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit


class FilterHelper: NSObject {

    class func filterNamesFor_iOS9(category: String?) -> [String]! {

        return FilterHelper.filterNamesFor_iOS9(category, exceptCategories: nil)
    }

    class func filterNamesFor_iOS9(category: String?, exceptCategories: [String]?) -> [String]! {
        
        var filterNames:[String] = []
        let all = CIFilter.filterNamesInCategory(category)
        
        for aFilterName in all {
            
            let attributes = CIFilter(name: aFilterName)!.attributes
            if exceptCategories?.count > 0 {
                var needExcept = false
                let categories = attributes[kCIAttributeFilterCategories] as! [String]
                for aCategory in categories {
                    if (exceptCategories?.contains(aCategory) == true) {
                        needExcept = true
                        break
                    }
                }
                if needExcept {
                    continue
                }
            }
            
            let availability = attributes[kCIAttributeFilterAvailable_iOS]
//            print("filtername:\(aFilterName), availability:\(availability)")
            
            if availability != nil &&
                availability as! String == "9" {
                    filterNames.append(aFilterName)
            }
        }
        return filterNames
    }
    
}

extension CIFilter {
    
    func categoriesStringForFilter() -> String {
        
        var categories = self.attributes[kCIAttributeFilterCategories]!.description
        
        categories = categories.stringByReplacingOccurrencesOfString("(", withString: "")
        categories = categories.stringByReplacingOccurrencesOfString(")", withString: "")
        categories = categories.stringByReplacingOccurrencesOfString("\n", withString: "")
        categories = categories.stringByReplacingOccurrencesOfString("   ", withString: "")
        categories = categories.stringByReplacingOccurrencesOfString("CICategory", withString: "")
        
        return categories
    }
}

