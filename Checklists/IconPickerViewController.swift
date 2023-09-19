//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by Maryna Bolotska on 18/09/23.
//

import UIKit

protocol IconPickerViewControllerDelegate: AnyObject {
  func iconPicker(
    _ picker: IconPickerViewController,
    didPick iconName: String)
}



class IconPickerViewController: UITableViewController {
  weak var delegate: IconPickerViewControllerDelegate?
    
//    let icons = [
//      "No Icon", "Appointments", "Birthdays", "Chores",
//      "Drinks", "Folder", "Groceries", "Inbox", "Photos", "Trips"
//    ]
    
    let systemImageNames = ["heart", "star", "circle"]
    
    // MARK: - Table View Delegates
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return systemImageNames.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
      let iconName = systemImageNames[indexPath.row]
      cell.textLabel!.text = iconName
   //   cell.imageView!.image = UIImage(named: iconName)
        cell.imageView!.image = UIImage(systemName: iconName)
      return cell
    }
    
    override func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath){
    if let delegate = delegate {
        let iconName = systemImageNames[indexPath.row]
        delegate.iconPicker(self, didPick: iconName)
      }
    }
}
