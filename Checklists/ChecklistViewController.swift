//
//  ViewController.swift
//  Checklists
//
//  Created by Maryna Bolotska on 29/08/23.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
  
    
    
//    var items = [ChecklistItem]()
    var checklist: Checklist!
    
    var row0item = ChecklistItem()
      var row1item = ChecklistItem()
      var row2item = ChecklistItem()
      var row3item = ChecklistItem()
      var row4item = ChecklistItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = checklist.name
//        let item1 = ChecklistItem()
//          item1.text = "Walk the dog"
//          items.append(item1)
//          let item2 = ChecklistItem()
//          item2.text = "Brush my teeth"
//          item2.checked = true
//          items.append(item2)
//          let item3 = ChecklistItem()
//          item3.text = "Learn iOS development"
//          item3.checked = true
//          items.append(item3)
//          let item4 = ChecklistItem()
//          item4.text = "Soccer practice"
//          items.append(item4)
//          let item5 = ChecklistItem()
//          item5.text = "Eat ice cream"
//          items.append(item5)
        
  //      loadChecklistItems()
    }

    
    func configureCheckmark(
      for cell: UITableViewCell,
      with item: ChecklistItem
    ){
        let label = cell.viewWithTag(1001) as! UILabel
          if item.checked {
            label.text = "√"
        } else {
            label.text = ""
          }
    }
    
    func configureText(
      for cell: UITableViewCell,
      with item: ChecklistItem
    ){
    let label = cell.viewWithTag(1000) as! UILabel
      label.text = item.text
    }
    // MARK: - Save data
   
    
    // MARK: - Navigation
    override func prepare(
      for segue: UIStoryboardSegue,
      sender: Any?
    ){
        // 1
        if segue.identifier == "AddItem" {
            // 2
            let controller = segue.destination as! ItemDetailViewController
            // 3
            controller.delegate = self
        }
   
           else if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(
              for: sender as! UITableViewCell) {
              controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
    
 
    
    override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
        return checklist.items.count
    }
    
    
    override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "ChecklistItem",
        for: indexPath)
        
//        let label = cell.viewWithTag(1000) as! UILabel
        
        
      let item = checklist.items[indexPath.row]
      configureText(for: cell, with: item)
      configureCheckmark(for: cell, with: item)
      return cell
    }

    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ){
    if let cell = tableView.cellForRow(at: indexPath) {
        let item = checklist.items[indexPath.row]
        item.checked.toggle()
        configureCheckmark(for: cell, with: item)
    }
      tableView.deselectRow(at: indexPath, animated: true)
        
    //    saveChecklistItems()
    }
    
    override func tableView(
      _ tableView: UITableView,
      commit editingStyle: UITableViewCell.EditingStyle,
      forRowAt indexPath: IndexPath
    ){
    // 1
        checklist.items.remove(at: indexPath.row)
    // 2
      let indexPaths = [indexPath]
      tableView.deleteRows(at: indexPaths, with: .automatic)
        
   //     saveChecklistItems()
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
    func itemDetailViewController(
      _ controller: ItemDetailViewController,
      didFinishAdding item: ChecklistItem
    ){
    let newRowIndex = checklist.items.count
        checklist.items.append(item)
      let indexPath = IndexPath(row: newRowIndex, section: 0)
      let indexPaths = [indexPath]
      tableView.insertRows(at: indexPaths, with: .automatic)
      navigationController?.popViewController(animated:true)
        
    //    saveChecklistItems()
    }
    
    
    func itemDetailViewController(
      _ controller: ItemDetailViewController,
      didFinishEditing item: ChecklistItem
    ){
    if let index = checklist.items.firstIndex(of: item) {
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) {
          configureText(for: cell, with: item)
        }
    }
      navigationController?.popViewController(animated: true)
        
    //    saveChecklistItems()
    }
    
    

    
    func addItemViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
}

