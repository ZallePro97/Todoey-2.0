//
//  CategoryTableViewController.swift
//  Todoey 2.0
//
//  Created by Zeljko Halle on 15/09/2018.
//  Copyright © 2018 Zeljko Halle. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    var categories: [Category] = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    //MARK: TableView Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
        
    }
    
    //MARK: Add new categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField: UITextField?
        
        let alert = UIAlertController(title: "New Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Add new category"
            
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField?.text!
            
            print(newCategory.name!)
            self.categories.append(newCategory)
         
            self.saveCategories()
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    //MARK: Data Manipulation methods
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving the categories! \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories(request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error loading categories! \(error)")
        }
        
        tableView.reloadData()
    }
    
}
