//
//  addProductViewController.swift
//  Shopping
//
//  Created by 杜鋆 on 28/03/2016.
//  Copyright © 2016 杜鋆. All rights reserved.
//

import UIKit
import CoreData

class addProductViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var amount: UITextField!
    let context = (UIApplication.sharedApplication().delegate as!
        AppDelegate).managedObjectContext
    
    var manageItem : Item! = nil
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if manageItem != nil {
            
            name.text = manageItem.name
            price.text = manageItem.price
            amount.text = manageItem.amount
            image.image = UIImage(named: manageItem.image!)
        }
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func dismiss(sender: AnyObject) {
    }
    
    
    func addPerosn(){
        //get entity and insert managePeopleObject
        let tableEntity = NSEntityDescription.entityForName("Item", inManagedObjectContext: context)
        manageItem = Item(entity:tableEntity!,insertIntoManagedObjectContext:context)
        
        //fill managedPeople object
//        name.text = manageItem.name
//        price.text = manageItem.price
//        amount.text = manageItem.amount
        manageItem.name = name.text
        manageItem.price = price.text
        manageItem.amount = amount.text
        //save
        do{
            try context.save()
            print("\(manageItem)")
        }catch{
            print("cao ni ma")
        }
        
        
    }
    
    func updatePerosn(){
        
        //fill managedPeople object
       
        manageItem.amount = amount.text
        //save
        do{
            try context.save()
        }catch{
            print("cao ni ma")
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func save(sender: AnyObject) {
        if manageItem == nil{
            addPerosn()
        }else{
            
            updatePerosn()}
        
        //go back to tableview controller
        navigationController?.popViewControllerAnimated(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
