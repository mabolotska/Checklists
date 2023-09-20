//
//  Checklist.swift
//  Checklists
//
//  Created by Maryna Bolotska on 09/09/23.
//

import UIKit

class Checklist: NSObject, Codable {
    var name = ""
    var items = [ChecklistItem]()
    
    var iconName = ""
    
    
    
    init(name: String, iconName: String = "No Icon") {
      self.name = name
      self.iconName = iconName
      super.init()
    }
    
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items {
            if !item.checked {
                count += 1
            }
        }
        return count
    }
}
