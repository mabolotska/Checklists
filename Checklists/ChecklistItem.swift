//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Maryna Bolotska on 31/08/23.
//

import UIKit

class ChecklistItem: NSObject, Codable {
    var dueDate = Date()
    var shouldRemind = false
    var itemID = -1
    
    
  var text = ""
  var checked = false
    
    
    override init() {
      super.init()
      itemID = DataModel.nextChecklistItemID()
    }
    
    func scheduleNotification() {
      if shouldRemind && dueDate > Date() {
        print("We should schedule a notification!")
      }
    }
}
