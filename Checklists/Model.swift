//
//  Model.swift
//  Checklists
//
//  Created by Maryna Bolotska on 12/09/23.
//

import UIKit


class Model {
    
    var checklist: Checklist!
    
    
    func documentsDirectory() -> URL {
      let paths = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask)
      return paths[0]
    }
    func dataFilePath() -> URL {
      return
    documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    func saveChecklistItems() {
      // 1
      let encoder = PropertyListEncoder()
      // 2
      do {
    // 3
        let data = try encoder.encode(checklist.items)
        // 4
        try data.write(
          to: dataFilePath(),
          options: Data.WritingOptions.atomic)
        // 5
    } catch { // 6
        print("Error encoding item array: \(error.localizedDescription)")
    } }
    
    // MARK: - Read data
    
    func loadChecklistItems() {
      // 1
      let path = dataFilePath()
      // 2
      if let data = try? Data(contentsOf: path) {
    // 3
        let decoder = PropertyListDecoder()
        do {
    // 4
            checklist.items = try decoder.decode(
            [ChecklistItem].self,
            from: data)
        } catch {
          print("Error decoding item array: \(error.localizedDescription)")
    } }
    }
}
