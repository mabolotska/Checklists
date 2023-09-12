//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Maryna Bolotska on 06/09/23.
//

import UIKit



class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {
    let cellIdentifier = "ChecklistCell"
    var dataModel: DataModel!
 //   var lists = [Checklist]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier:
        cellIdentifier)
        dataModel.loadChecklists()
      
        // Add placeholder data
          var list = Checklist(name: "Birthdays")
        dataModel.lists.append(list)
          list = Checklist(name: "Groceries")
        dataModel.lists.append(list)
          list = Checklist(name: "Cool Apps")
        dataModel.lists.append(list)
          list = Checklist(name: "To Do")
        dataModel.lists.append(list)
        
        list = Checklist(name: "Name of the checklist")
        
        // Add placeholder item data
        for list in dataModel.lists {
          let item = ChecklistItem()
          item.text = "Item for \(list.name)"
          list.items.append(item)
        }
    }
    
  

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataModel.lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        let checklist = dataModel.lists[indexPath.row]
         cell.textLabel!.text = checklist.name
         cell.accessoryType = .detailDisclosureButton
          return cell
    }
    

    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ){
        let checklist = dataModel.lists[indexPath.row]
        performSegue(
            withIdentifier: "ShowChecklist",
            sender: checklist)
    }
    
    override func tableView(
      _ tableView: UITableView,
      commit editingStyle: UITableViewCell.EditingStyle,
      forRowAt indexPath: IndexPath
    ){
        dataModel.lists.remove(at: indexPath.row)
      let indexPaths = [indexPath]
      tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    // MARK: - Navigation

    
    override func prepare(
      for segue: UIStoryboardSegue,
      sender: Any?
    ){
    if segue.identifier == "ShowChecklist" {
        let controller = segue.destination as!
    ChecklistViewController
        controller.checklist = sender as? Checklist
      } else if segue.identifier == "AddChecklist" {
          let controller = segue.destination as!
      ListDetailViewController
          controller.delegate = self
        }
    }
    
        //making segue by code
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
    let controller = storyboard!.instantiateViewController(
        withIdentifier: "ListDetailViewController") as! ListDetailViewController
      controller.delegate = self
      let checklist = dataModel.lists[indexPath.row]
      controller.checklistToEdit = checklist
      navigationController?.pushViewController(controller, animated: true)
    }
    
    
    // MARK: - List Detail View Controller Delegates
    func listDetailViewControllerDidCancel(
      _ controller: ListDetailViewController
    ){
      navigationController?.popViewController(animated: true)
    }
    func listDetailViewController(
      _ controller: ListDetailViewController,
      didFinishAdding checklist: Checklist
    ){
    let newRowIndex = dataModel.lists.count
        dataModel.lists.append(checklist)
      let indexPath = IndexPath(row: newRowIndex, section: 0)
      let indexPaths = [indexPath]
      tableView.insertRows(at: indexPaths, with: .automatic)
      navigationController?.popViewController(animated: true)
    }
    func listDetailViewController(
      _ controller: ListDetailViewController,
      didFinishEditing checklist: Checklist
    ){
    if let index = dataModel.lists.firstIndex(of: checklist) {
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.textLabel!.text = checklist.name
             }
         }
           navigationController?.popViewController(animated: true)
         }

}
