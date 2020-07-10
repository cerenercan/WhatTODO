//
//  ViewController.swift
//  WhatTODO
//
//  Created by Ceren Ercan on 22.06.2020.
//  Copyright © 2020 Ceren Ercan. All rights reserved.
//

//        DOCUMENTS DIRECTORY TO FIND THE PLIST
//        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//        print(dataFilePath!)

import UIKit

class ToDoListViewController: UITableViewController {

    
    var itemArray = [Items]()
    
    //        CREATING NEW DIRECTORY FOR THE NEW PLIST THAT WE WILL CREATE
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
 
    }
    
    //MARK: - DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
//    ADDING ROWS FOR THE NEW ADDED ITEM AND ADDING CHECKMARKS TO THEM IF THE ACTIVITY IS COMPLETED OR BOOL==TRUE OR REMOVING
//    THE CHECKMARK TO UNDO THE ACTIVITY OR BOOL==FALSE
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
 //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
//            What will happen once the user clicks the Add Item button on UIAlert
            let newItem = Items()
            newItem.title = textField.text!
            
//        ADDING THE NEW ITEM TO THE ARRAY AND THE TABLE
            self.itemArray.append(newItem)
            self.saveItems()
            
        }
//        CREATING NEW ITEM BY PRESSING THE ADD(+) BUTTON
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item."
            textField = alertTextField
            print(alertTextField.text!)
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Model Manipulation Methods
//    ENCODE THE ITEMS AND MAKING THE CHANGES IN THE PLIST BUT NOT SAVING THE ADDED ITEMS
    func saveItems(){
        
        let encoder = PropertyListEncoder()
        
        do{
            
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        } catch {
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(){
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            
            let decoder = PropertyListDecoder()
            
            do{
                
            itemArray = try decoder.decode([Items].self, from: data)
                
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
        
    }
}

