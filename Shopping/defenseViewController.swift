//
//  defenseViewController.swift
//  player
//
//  Created by 杜鋆 on 06/03/2016.
//  Copyright © 2016 杜鋆. All rights reserved.
//

import UIKit
import MapKit
import CoreData
class defenseViewController: UIViewController, NSFetchedResultsControllerDelegate
 {

    var peopleModel = People(fromXMLFile: "people.xml")
    
    var v : Int!
    var person : Person!
    
    var personArray = [Person]()
    
    var index = 0
    var l :Double!
    var long : Double!
    
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var change: UISegmentedControl!
    
    @IBAction func change(sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            mapview.mapType = .Standard
        case 1:
            mapview.mapType = .Satellite
        case 2:
            mapview.mapType = .Hybrid
        default:
            mapview.mapType = .Satellite
        }
    }
    func FetchRequest() ->NSFetchRequest{
        
        let request = NSFetchRequest(entityName: "Item")
        //how to sort and what to query
        let sortor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sortor]
        //        let predict = NSPredicate(format: "%K == %@","name","Sabin Tabirca")
        //        request.predicate = predict
        return request
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Person Info"
        index = v
        number.text = "1"
        l = Double(person.latitude)
        long = Double(person.longitude)
        var location = CLLocationCoordinate2D(
            latitude: l,
            longitude: long
        )
        
        var span = MKCoordinateSpanMake(0.1, 0.1)
        var region = MKCoordinateRegion(center: location, span: span)
        
        mapview.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = person.marker
        
        
        mapview.addAnnotation(annotation);
        if person != nil{
            name.text = person.name
            address.text = person.club
            age.text = "€" + person.price
            country.text = person.country
            des.text = person.des
            personimage.image = UIImage(named: person.image)
        }
        
        frc = NSFetchedResultsController(fetchRequest: FetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        
        do{
            try frc.performFetch()
            
        }catch{
            print("fetch core data error")
        }
        

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var mapview: MKMapView!
    
    @IBOutlet weak var des: UITextView!
    
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var personimage: UIImageView!
 
       override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "buy2" {
            let controller = segue.destinationViewController as! ProductTableViewController
            //            controller.person = self.person
            controller.person = peopleModel.data[index]        }
        else if segue.identifier == "g2"{
            let controller = segue.destinationViewController as! DetailViewController
            controller.person = self.person
            //            controller.person = peopleModel.data[index]
            
        }

    }
    var manageItem : Item! = nil
    var managedP : [Item] = []
    let context = (UIApplication.sharedApplication().delegate as!
        AppDelegate).managedObjectContext
    var frc : NSFetchedResultsController! = nil
    var currentPerson = People(fromXMLFile: "people.xml").data
    var hasAdd : Bool = false
 
    @IBAction func tianjia(sender: AnyObject) {
        let tableEntity = NSEntityDescription.entityForName("Item", inManagedObjectContext: context)
        manageItem = Item(entity:tableEntity!,insertIntoManagedObjectContext:context)
        
        manageItem.name = name.text
        manageItem.price = person.price
        
        manageItem.amount = number.text!
        
        manageItem.image = person.image
        //save
        do{
            try context.save()
            print("\(manageItem)")
        }catch{
            print("where data")
        }

    }

 
 
    
}