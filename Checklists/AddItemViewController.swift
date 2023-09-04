//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Maryna Bolotska on 01/09/23.
//

import UIKit


protocol AddItemViewControllerDelegate: AnyObject {
  func addItemViewControllerDidCancel(
    _ controller: AddItemViewController)
  func addItemViewController(
    _ controller: AddItemViewController,
    didFinishAdding item: ChecklistItem
  )
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
 weak var delegate: AddItemViewControllerDelegate?
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var textField: UITextField!
    
    override func tableView(
        _ tableView: UITableView,
        willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
      //  navigationController?.popViewController(animated: true)
        
        delegate?.addItemViewControllerDidCancel(self)
    }
    @IBAction func done() {
        
        let item = ChecklistItem()
         item.text = textField.text!
         delegate?.addItemViewController(self, didFinishAdding: item)
        
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
