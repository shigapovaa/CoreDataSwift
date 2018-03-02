//
//  TableViewController.swift
//  CoreDataSwift
//
//  Created by Alsu Shigapova on 01.03.2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    let cellIdentifier = "cell"
    let segueIdetifier = "segue1"
    var models:[Images] = []
    
    lazy var persistentContainer : NSPersistentContainer? = {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return delegate.persistentContainer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllModels()
        /*let predicate = NSPredicate(format: "imageName = %@", "iName")
        fetchModels(with: predicate)
         */
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        saveNewModel()
        tableView.reloadData()
    }
    
    // MARK: - Custom methods
    
    func fetchAllModels() {
        guard let context = persistentContainer?.viewContext else { return }
        
        let request: NSFetchRequest<Images> = Images.fetchRequest()
        do {
            models = try context.fetch(request)
            tableView.reloadData()
        }
        catch let error {
            print("Error when fetching: \(error)")
        }
    }
    
    func fetchModels(with predicate: NSPredicate) {
        guard let context = persistentContainer?.viewContext else { return }
        
        let request: NSFetchRequest<Images> = Images.fetchRequest()
        request.predicate = predicate
        do {
            models = try context.fetch(request)
            tableView.reloadData()
        }
        catch let error {
            print("Error when fetching: \(error)")
        }
    }
    
    func saveNewModel() {
        guard let context = persistentContainer?.viewContext else { return }
        
        let model = Images(context: context)
        model.imageName = "someName"
        model.image = UIImage(named: "someImage") 
        
        do {
            models.append(model)
           try context.save()
        }
        catch let error {
            print("Error when saving: \(error)")
        }
    }
    
    func removeModel(at indexPath: IndexPath) {
        guard let context = persistentContainer?.viewContext else { return }
        
        let model = models[indexPath.row]
        context.delete(model)
        
        do {
            models.remove(at: indexPath.row)
            try context.save()
        }
        catch let error {
            print("Error when removing: \(error)")
        }
        
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    
    func update(with indexPath: IndexPath) {
        guard let context = persistentContainer?.viewContext else { return }
        let model = models[indexPath.row]
        model.imageName = "Selected model"
        
        tableView.reloadRows(at: [indexPath], with: .fade)
        
        do {
            models[indexPath.row] = model
            try context.save()
        }
        catch let error {
            print("Error when updating: \(error)")
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return models.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let model = models[indexPath.row]
        
        cell.textLabel?.text = model.imageName
        cell.imageView?.image = model.image as? UIImage
        
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeModel(at: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        update(with: indexPath)
        let model = models[indexPath.row]
        performSegue(withIdentifier: segueIdetifier, sender: model)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdetifier {
            let destinitionController = segue.destination as! ViewController
            //let indexPath = tableView.cellForRowAtIndexPath(indexPath)
            let model = models[(tableView.indexPathForSelectedRow?.row)!]
            destinitionController.textOfLabelCell = model.imageName!
            destinitionController.imageOfImageCell = model.image as? UIImage
        }
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
