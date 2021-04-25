//
//  ViewController.swift
//  Challenge2
//
//  Created by Keith Crooc on 2021-04-24.
//

import UIKit

class ViewController: UITableViewController {
    
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptAddItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearList))
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        
        toolbarItems = [share]
        navigationController?.isToolbarHidden = false
        
        
    }
    
    //  the amount of cells to be shown function
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    
    //  populating the table view with items in an array
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func promptAddItem() {
        let enterItem = UIAlertController(title: "Enter Item", message: nil, preferredStyle: .alert)
        enterItem.addTextField()
        
        let addToList = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak enterItem] action in
            guard let item = enterItem?.textFields?[0].text else { return }
            self?.add(item)
        }
        
        enterItem.addAction(addToList)
        present(enterItem, animated: true)
    }
    
    @objc func clearList() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    @objc func shareList(){
        let list = shoppingList.joined(separator: "\n")
        
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func add(_ item: String) {
        
        shoppingList.insert(item, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    
    
   
    
    


}

