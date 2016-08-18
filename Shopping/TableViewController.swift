//
//  TableViewController.swift
//  player
//
//  Created by 杜鋆 on 29/02/2016.
//  Copyright © 2016 杜鋆. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  var peopleModel = People(fromXMLFile:"people.xml")
     var player = [Person]()
    @IBOutlet weak var image: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        var images: [UIImage] = []
       

        images.append(UIImage(named: "2")!)
        images.append(UIImage(named: "3")!)
    
        image.animationImages = images
        image.animationDuration = 3.0
        image.startAnimating()
       self.title = "All"
        for(var i = 0; i < peopleModel.data.count;i++){
          
            player.append(peopleModel.data[i])
            
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
        return player.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TableViewCell
        // Configure the cell...
//       
        let person = player[indexPath.row]
//        
      cell.name.text = person.name
        cell.club.text = person.club
        cell.age.text = person.amount
        cell.num.text = "€" + person.price
     cell.ima.image = UIImage(named: person.image)
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segue1"{
            print(peopleModel.data[0].marker)
            //get index path
            let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell)
            
            //get destionation controller
            let controller = segue.destinationViewController as! ViewController
            
            //push data
            controller.v = indexPath!.row
            controller.person = player[indexPath!.row]
            
        }
    
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewControllerWithIdentifier("ViewController") as UIViewController
//        self.presentViewController(vc, animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

}
