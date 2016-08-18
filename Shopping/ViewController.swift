//
//  ViewController.swift
//  player
//
//  Created by 杜鋆 on 29/02/2016.
//  Copyright © 2016 杜鋆. All rights reserved.
//

import UIKit
import MapKit
import CoreData
class ViewController: UIViewController , NSFetchedResultsControllerDelegate

 {
    var peopleModel = People(fromXMLFile: "people.xml")
    
    var v : Int!
    var person : Person!
    
    var personArray = [Person]()
    
    @IBOutlet weak var number: UITextField!
    var index = 0
    var l :Double!
    var long : Double!
    let context = (UIApplication.sharedApplication().delegate as!
        AppDelegate).managedObjectContext
    
    var manageItem : Item! = nil
    var managedP : [Item] = []
  
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
        number.text = "1"
       
        index = v
         l = Double(person.latitude)
         long = Double(person.longitude)
        let location = CLLocationCoordinate2D(
            latitude: l,
            longitude: long
        )
        
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapview.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = person.marker
        
        
        mapview.addAnnotation(annotation);
        if person != nil{
            name.text = person.name
            address.text = person.club
            age.text = "€" + person.price
         
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
    @IBAction func next(sender: AnyObject) {
        index++
        if(index >= peopleModel.data.count){
            index = 0
        }
        name.text = peopleModel.data[index].name
        age.text = "€" + peopleModel.data[index].price
      
        address.text=peopleModel.data[index].club
        des.text = peopleModel.data[index].des
        personimage.image = UIImage(named: peopleModel.data[index].image)
        
        l = Double(peopleModel.data[index].latitude)
        long = Double(peopleModel.data[index].longitude)
        var location = CLLocationCoordinate2D(
            latitude: l,
            longitude: long
        )
        
        var span = MKCoordinateSpanMake(0.5, 0.5)
        var region = MKCoordinateRegion(center: location, span: span)
        
        mapview.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = peopleModel.data[index].marker
        
        
        mapview.addAnnotation(annotation);
        
        
        
    }
    @IBAction func pre(sender: AnyObject) {
        
        index--
        if(index < 0){
            index = peopleModel.data.count - 1
        }
        name.text = peopleModel.data[index].name
        age.text = "€" + peopleModel.data[index].price
       
        address.text=peopleModel.data[index].club
        des.text = peopleModel.data[index].des
        personimage.image = UIImage(named: peopleModel.data[index].image)
        l = Double(peopleModel.data[index].latitude)
        long = Double(peopleModel.data[index].longitude)
        var location = CLLocationCoordinate2D(
            latitude: l,
            longitude: long
        )
        
        var span = MKCoordinateSpanMake(0.5, 0.5)
        var region = MKCoordinateRegion(center: location, span: span)
        
        mapview.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = peopleModel.data[index].marker

        
        
        mapview.addAnnotation(annotation);
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "buy" {
            let controller = segue.destinationViewController as! ProductTableViewController
//            controller.person = self.person
            controller.person = peopleModel.data[index]
        }
        else if segue.identifier == "segue6"{
            let controller = segue.destinationViewController as! DetailViewController
            //            controller.person = self.person
            controller.person = peopleModel.data[index]
        
        }
    }
    
    var frc : NSFetchedResultsController! = nil
    var currentPerson = People(fromXMLFile: "people.xml").data
    var hasAdd : Bool = false
  

    @IBAction func buy(sender: AnyObject) {
       check()
        if hasAdd{
            updatePerson()
        }
        else{
            add()
        }

    }
    
    func check(){
         frc = NSFetchedResultsController(fetchRequest: FetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        do{
            try frc.performFetch()
            
        }catch{
            print("fetch core data error")
        }

        managedP = frc.fetchedObjects as! [Item]
        
        for person in managedP {
            if person.name == self.currentPerson[index].name{
                manageItem = person
                hasAdd = true
            }
        }
    }

    
    
    
   func add() {
        let tableEntity = NSEntityDescription.entityForName("Item", inManagedObjectContext: context)
        manageItem = Item(entity:tableEntity!,insertIntoManagedObjectContext:context)

        manageItem.name = name.text
        manageItem.price = person.price

        manageItem.amount = number.text!

        manageItem.image = currentPerson[index].image
        //save
        do{
            try context.save()
            print("\(manageItem)")
        }catch{
            print("where data")
        }
        

    }
    func updatePerson(){
       manageItem.amount = String(Int((manageItem.amount)!)! + Int(number.text!)!)
        
    }
    
}

