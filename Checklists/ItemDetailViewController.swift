//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Maryna Bolotska on 01/09/23.
//

import UIKit


protocol ItemDetailViewControllerDelegate: AnyObject {
  func addItemViewControllerDidCancel(
    _ controller: ItemDetailViewController)
  func itemDetailViewController(
    _ controller: ItemDetailViewController,
    didFinishAdding item: ChecklistItem
  )
    
    func itemDetailViewController(
      _ controller: ItemDetailViewController,
      didFinishEditing item: ChecklistItem
    )
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
 weak var delegate: ItemDetailViewControllerDelegate?
    
    var itemToEdit: ChecklistItem?
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var shouldRemindSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
  
    
    override func viewDidLoad() {
      if let item = itemToEdit {
        title = "Edit Item"
        textField.text = item.text
          
          shouldRemindSwitch.isOn = item.shouldRemind  // add this
              datePicker.date = item.dueDate     
      }
        
        //the same code as above
//        if let itemToEdit = itemToEdit {
//          title = "Edit Item"
//          textField.text = itemToEdit.text
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    
    override func tableView(
        _ tableView: UITableView,
        willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
        return nil
    }
    
    
    @IBAction func cancel() {
      //  navigationController?.popViewController(animated: true)
        
        delegate?.addItemViewControllerDidCancel(self)
    }
    @IBAction func done() {
        
        if let item = itemToEdit {
          item.text = textField.text!
            
            item.shouldRemind = shouldRemindSwitch.isOn
              item.dueDate = datePicker.date
          delegate?.itemDetailViewController(self, didFinishEditing: item)
        } else {
          let item = ChecklistItem()
          item.text = textField.text!
            
            item.checked = false
            item.shouldRemind = shouldRemindSwitch.isOn
            item.dueDate = datePicker.date
          delegate?.itemDetailViewController(self, didFinishAdding: item)
      }
        
    }
    
   
    
    // MARK: - Text Field Delegates
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(
            in: stringRange,
            with: string)
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        } else {
            doneBarButton.isEnabled = true
        }
        return true
    }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
    
}
