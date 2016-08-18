//
//  CheckViewController.swift
//  Shopping
//
//  Created by 杜鋆 on 30/03/2016.
//  Copyright © 2016 杜鋆. All rights reserved.
//

import UIKit
import CoreData
class CheckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,NSFetchedResultsControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var money: UILabel!

    @IBOutlet weak var what: UILabel!
    var person : Person!
    var totals : Double = 0.0
    var zong : Double = 0.0
    var finalM : Double = 0.0
     var pickerData: [String] = [String]()
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var type: UILabel!
    var managedItem : Item! = nil
    var frc : NSFetchedResultsController! = nil
    var managedProductObject : Item! = nil
    var itemObject : [Item] = []
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var ship: UITextField!
    @IBOutlet weak var deliver: UIPickerView!
    @IBOutlet weak var final: UILabel!
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
    


    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        deliver.delegate = self
        deliver.dataSource = self
    
        frc = NSFetchedResultsController(fetchRequest: makeFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        do{ try frc.performFetch()}
        catch{
            
            print("fetch core data")
        }
       
       pickerData = ["UPS", "EMS", "ANpost","ShengT","Daily"]
        itemObject = frc.fetchedObjects as! [Item]
        for person in itemObject {
            totals = totals + Double(person.amount!)! * Double(person.price!)!
            zong = zong + Double(person.amount!)!
        }
       money.text = "€" + String(totals)
       
        
         final.text = money.text
         what.text = "UPS"
        
        
        // Do any additional setup after loading the view.
    }
   
  
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(row == 0)
        {
            self.view.backgroundColor = UIColor.whiteColor();
            finalM = totals + 15
            final.text = "€" + String(finalM)
            type.text = pickerData[0]
        }
        else if(row == 1)
        {
            table.backgroundColor = UIColor.redColor();
            finalM = totals + 18
            final.text = "€" + String(finalM)
            type.text = pickerData[1]
        }
        else if(row == 2)
        {
            table.backgroundColor =  UIColor.greenColor();
            finalM = totals + 10
            final.text = "€" + String(finalM)
            type.text = pickerData[2]
        }
        else if(row == 3)
        {
           table.backgroundColor =  UIColor.yellowColor();
            finalM = totals + 20
            final.text = "€" + String(finalM)
            type.text = pickerData[3]
        }
        else if(row == 4)
        {
           table.backgroundColor =  UIColor.purpleColor();
            finalM = totals + 5
            final.text = "€" + String(finalM)
            type.text = pickerData[4]
        }
    }
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return frc.sections![section].numberOfObjects
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("block", forIndexPath: indexPath)
        
        // Configure the cell...from frc data
        managedProductObject = frc.objectAtIndexPath(indexPath) as! Item
        
        let testString:NSString = "€ \(managedProductObject.price!) *  \(managedProductObject.amount!) pieces"
        cell.textLabel?.text = managedProductObject.name
        cell.detailTextLabel?.text = testString as String
        cell.imageView?.image = UIImage(named: managedProductObject.image!)
        return cell
    }
    

    var managedHObject : History!
    
    var manageItem : Item! = nil
    var managedP : [Item] = []
    @IBAction func save(sender: AnyObject) {
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        let tableEntity = NSEntityDescription.entityForName("History", inManagedObjectContext: context)
        managedHObject = History(entity: tableEntity!, insertIntoManagedObjectContext: context)
    
        //fill managedPeople object
        //        name.text = manageItem.name
        //        price.text = manageItem.price
        //        amount.text = manageItem.amount
        managedHObject.name = name.text
        managedHObject.price = final.text
        managedHObject.date = "\(components.year)/\(components.month)/\(components.day)"
        managedHObject.address = ship.text
        managedHObject.phone = phone.text
        managedHObject.number = String(zong)
        managedHObject.ship = what.text
    
        //save
        do{
            try context.save()
            print("\(managedHObject)")
        }catch{
            print("where data")
        }
        
        
        managedP = frc.fetchedObjects as! [Item]
        for person in managedP {
            context.deleteObject(person)
            do{
                try context.save()
            }catch{
                
                print("coredata has been deleted")
            }
            
        }


        
    }
 
    

}
