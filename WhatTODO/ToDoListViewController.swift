//
//  ViewController.swift
//  WhatTODO
//
//  Created by Ceren Ercan on 22.06.2020.
//  Copyright © 2020 Ceren Ercan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray = ["item1", "item2", "item3"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
}

