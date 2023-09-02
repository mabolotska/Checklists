//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Maryna Bolotska on 01/09/23.
//

import UIKit

class AddItemViewController: UITableViewController {
    

    @IBOutlet weak var textField: UITextField!
    
    override func tableView(
      _ tableView: UITableView,
      willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
    return nil
    }
    

    
    @IBAction func cancel() {
      navigationController?.popViewController(animated: true)
    }
    @IBAction func done() {
      navigationController?.popViewController(animated: true)
    }
}
