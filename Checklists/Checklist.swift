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
    
    init(name: String) {
      self.name = name
      super.init()
    }
}
