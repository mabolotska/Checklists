//
//  ViewController.swift
//  Checklists
//
//  Created by Maryna Bolotska on 29/08/23.
//

import UIKit

class ChecklistViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
    return 10 }
    
    
    override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "ChecklistItem",
        for: indexPath)
      // Add the following code
      let label = cell.viewWithTag(1000) as! UILabel
        if indexPath.row % 5 == 0 {
          label.text = "Walk the dog"
        } else if indexPath.row % 5 == 1 {
          label.text = "Brush my teeth"
        } else if indexPath.row % 5 == 2 {
          label.text = "Learn iOS development"
        } else if indexPath.row % 5 == 3 {
          label.text = "Soccer practice"
        } else if indexPath.row % 5 == 4 {
          label.text = "Eat ice cream"
        }
      // End of new code block
    return cell }

}

