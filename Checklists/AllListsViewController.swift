//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Maryna Bolotska on 06/09/23.
//

import UIKit


class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    let cellIdentifier = "ChecklistCell"
    var dataModel: DataModel!
 //   var lists = [Checklist]()

    override func viewDidLoad() {
        super.viewDidLoad()

     //   tableView.register(UITableViewCell.self, forCellReuseIdentifier:cellIdentifier)
        
        
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
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      tableView.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      navigationController?.delegate = self
        let index = dataModel.indexOfSelectedChecklist
        if index >= 0 && index < dataModel.lists.count {
        let checklist = dataModel.lists[index]
        performSegue(
          withIdentifier: "ShowChecklist",
          sender: checklist)
      }
    }
  

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataModel.lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        let cell: UITableViewCell!
        if let tmp = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
          cell = tmp
        } else {
          cell = UITableViewCell(
            style: .subtitle,
            reuseIdentifier: cellIdentifier)
        }
        
        let checklist = dataModel.lists[indexPath.row]
         cell.textLabel!.text = checklist.name
         cell.accessoryType = .detailDisclosureButton
        cell.detailTextLabel!.text = "\(checklist.countUncheckedItems()) Remaining"
          
        
        let count = checklist.countUncheckedItems()
        cell.detailTextLabel!.text = count == 0 ? "All Done" : "\(count) Remaining"
        
       
        if checklist.items.count == 0 {
          cell.detailTextLabel!.text = "(No Items)"
        } else {
          cell.detailTextLabel!.text = count == 0 ? "All Done" : "\(count) Remaining"
        }
        
        return cell
    }
    

    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ){
        dataModel.indexOfSelectedChecklist = indexPath.row
        
        let checklist = dataModel.lists[indexPath.row]
        performSegue(
            withIdentifier: "ShowChecklist",
            sender: checklist)
        
        // add this line:
          UserDefaults.standard.set(
            indexPath.row,
            forKey: "ChecklistIndex")
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

    //we use Userdefaults to check if opened app and if yes we redirect to that vc
    // MARK: - Navigation Controller Delegates
    func navigationController(
      _ navigationController: UINavigationController,
      willShow viewController: UIViewController, animated: Bool ){
          // Was the back button tapped?
          if viewController === self {
       //     UserDefaults.standard.set(-1, forKey: "ChecklistIndex")
              dataModel.indexOfSelectedChecklist = -1
          }
        }
}
