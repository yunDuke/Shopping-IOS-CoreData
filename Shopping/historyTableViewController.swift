//
//  historyTableViewController.swift
//  Shopping
//
//  Created by 杜鋆 on 31/03/2016.
//  Copyright © 2016 杜鋆. All rights reserved.
//

import UIKit
import CoreData
class historyTableViewController: UITableViewController,NSFetchedResultsControllerDelegate{
    
    var person : Person!
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var managedItem : History! = nil
    var frc : NSFetchedResultsController! = nil
    var managedObject : History! = nil
     var itemObject : [History] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredhistory = [History]()
    @IBAction func Back(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    func makeFetchRequest()->NSFetchRequest{
        
        let request = NSFetchRequest(entityName: "History")
        
        //give how to sort and what to query
        let sorter = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sorter]
        
        //        let predicate = NSPredicate(format: "%K == %@", "name","duyun")
        //        request.predicate = predicate
        return request
        
    }
 
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.reloadData()
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredhistory = itemObject.filter{ history in
            return history.name!.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        frc = NSFetchedResultsController(fetchRequest: makeFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        do{ try frc.performFetch()}
        catch{
            
            print("fetch core data")
        }

        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        let fetchRequest = NSFetchRequest()
        let entityDesc = NSEntityDescription.entityForName("History", inManagedObjectContext: context)
        fetchRequest.entity = entityDesc
        do{
            itemObject  = try context.executeFetchRequest(fetchRequest) as! [History]
            
        }catch{
            let fetchError = error as NSError
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    @IBAction func clean(sender: AnyObject) {
      itemObject = frc.fetchedObjects as! [History]
        for person in itemObject {
            context.deleteObject(person)
        }
        do{
            try context.save()
        }catch{
            print("core data can not save after delete")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.active && searchController.searchBar.text != ""{
            return filteredhistory.count
        }
        return frc.sections![section].numberOfObjects
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("his", forIndexPath: indexPath)
        
        // Configure the cell...from frc data
//        managedObject = frc.objectAtIndexPath(indexPath) as! History

        let histroy: History
        if searchController.active && searchController.searchBar.text != "" {
            histroy = filteredhistory[indexPath.row]
        } else {
            histroy = frc.objectAtIndexPath(indexPath) as! History
        }
        
        
        
        
        
        cell.textLabel?.text =  "It totaly cost \(histroy.price!)"
        cell.detailTextLabel?.text = "\(histroy.name!) bought \(histroy.number!) pieces"
       
        return cell
    }
    

    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //fetech managepeople
            managedObject = frc.objectAtIndexPath(indexPath) as! History
            //delete it and save
            context.deleteObject(managedObject)
            do{
                try context.save()
            }catch{
                
                print("coredata has been deleted")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "more"{
            // get index path and fetch the
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            managedItem = frc.objectAtIndexPath(indexPath!) as! History
            
            let controller = segue.destinationViewController as! showHistoryViewController
            
            controller.manageItem = managedItem
            
            
        }
    
    }
    

    
}
extension historyTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
}
}
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */



    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

