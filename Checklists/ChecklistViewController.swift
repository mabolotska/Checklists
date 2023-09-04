//
//  ViewController.swift
//  Checklists
//
//  Created by Maryna Bolotska on 29/08/23.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    
    
    var items = [ChecklistItem]()
    
    
    var row0item = ChecklistItem()
      var row1item = ChecklistItem()
      var row2item = ChecklistItem()
      var row3item = ChecklistItem()
      var row4item = ChecklistItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        let item1 = ChecklistItem()
          item1.text = "Walk the dog"
          items.append(item1)
          let item2 = ChecklistItem()
          item2.text = "Brush my teeth"
          item2.checked = true
          items.append(item2)
          let item3 = ChecklistItem()
          item3.text = "Learn iOS development"
          item3.checked = true
          items.append(item3)
          let item4 = ChecklistItem()
          item4.text = "Soccer practice"
          items.append(item4)
          let item5 = ChecklistItem()
          item5.text = "Eat ice cream"
          items.append(item5)
    }

    
    func configureCheckmark(
      for cell: UITableViewCell,
      with item: ChecklistItem
    ){
    if item.checked {
        cell.accessoryType = .checkmark
      } else {
        cell.accessoryType = .none
      }
    }
    
    func configureText(
      for cell: UITableViewCell,
      with item: ChecklistItem
    ){
    let label = cell.viewWithTag(1000) as! UILabel
      label.text = item.text
    }
    
    // MARK: - Navigation
    override func prepare(
      for segue: UIStoryboardSegue,
      sender: Any?
    ){
        // 1
          if segue.identifier == "AddItem" {
            // 2
            let controller = segue.destination as! AddItemViewController
            // 3
            controller.delegate = self
        } }
    
    override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
        return items.count
    }
    
    
    override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "ChecklistItem",
        for: indexPath)
      let item = items[indexPath.row]
      configureText(for: cell, with: item)
      configureCheckmark(for: cell, with: item)
      return cell
    }

    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ){
    if let cell = tableView.cellForRow(at: indexPath) {
        let item = items[indexPath.row]
        item.checked.toggle()
        configureCheckmark(for: cell, with: item)
    }
      tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(
      _ tableView: UITableView,
      commit editingStyle: UITableViewCell.EditingStyle,
      forRowAt indexPath: IndexPath
    ){
    // 1
      items.remove(at: indexPath.row)
    // 2
      let indexPaths = [indexPath]
      tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    
    @IBAction func addItem() {
//        let newRowIndex = items.count
//          let item = ChecklistItem()
//          item.text = "I am a new row"
//          items.append(item)
//          let indexPath = IndexPath(row: newRowIndex, section: 0)
//          let indexPaths = [indexPath]
//          tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    
    // MARK: - Add Item ViewController Delegates
    func addItemViewController(
      _ controller: AddItemViewController,
      didFinishAdding item: ChecklistItem
    ){
    let newRowIndex = items.count
        items.append(item)
      let indexPath = IndexPath(row: newRowIndex, section: 0)
      let indexPaths = [indexPath]
      tableView.insertRows(at: indexPaths, with: .automatic)
      navigationController?.popViewController(animated:true)
    }
    
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        navigationController?.popViewController(animated: true)
    }
}

