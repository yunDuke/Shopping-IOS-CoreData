//
//  ProductTableViewController.swift
//  Shopping
//
//  Created by 杜鋆 on 28/03/2016.
//  Copyright © 2016 杜鋆. All rights reserved.
//

import UIKit
import CoreData
class ProductTableViewController: UITableViewController ,NSFetchedResultsControllerDelegate{
    
    var person : Person!
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var managedItem : Item! = nil
    var frc : NSFetchedResultsController! = nil
    var managedProductObject : Item! = nil
    
    @IBAction func Back(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    func makeFetchRequest()->NSFetchRequest{
        
        let request = NSFetchRequest(entityName: "Item")
        
        //give how to sort and what to query
        let sorter = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sorter]
        
        //        let predicate = NSPredicate(format: "%K == %@", "name","duyun")
        //        request.predicate = predicate
        return request
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
  
        //make the data available in fec
        frc = NSFetchedResultsController(fetchRequest: makeFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        do{ try frc.performFetch()}
        catch{
            
            print("fetch core data")
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return frc.sections![section].numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cells", forIndexPath: indexPath)
        
        // Configure the cell...from frc data
        managedProductObject = frc.objectAtIndexPath(indexPath) as! Item

        var testString:NSString = "€ \(managedProductObject.price!) *  \(managedProductObject.amount!) pieces"
        cell.textLabel?.text = managedProductObject.name
        cell.detailTextLabel?.text = testString as String
        cell.imageView?.image = UIImage(named: managedProductObject.image!)
        return cell
    }
    

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //fetech managepeople
            managedItem = frc.objectAtIndexPath(indexPath) as! Item
            //delete it and save
            context.deleteObject(managedItem)
            do{
                try context.save()
            }catch{
                
                print("coredata has been deleted")
            }
        }
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    
    var manageItem : Item! = nil
    var managedP : [Item] = []
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segue_update"{
            // get index path and fetch the
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            managedItem = frc.objectAtIndexPath(indexPath!) as! Item
            
            let controller = segue.destinationViewController as! addProductViewController
            
           controller.manageItem = managedItem
            
            
        }
        else if segue.identifier == "check"{
            let controller = segue.destinationViewController as! CheckViewController
            controller.frc = self.frc
           
            
            

        
        }
    }
    
    

}
