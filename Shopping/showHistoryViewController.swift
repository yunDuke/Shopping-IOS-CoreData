//
//  showHistoryViewController.swift
//  Shopping
//
//  Created by 杜鋆 on 03/04/2016.
//  Copyright © 2016 杜鋆. All rights reserved.
//

import UIKit

class showHistoryViewController: UIViewController {
    let context = (UIApplication.sharedApplication().delegate as!
        AppDelegate).managedObjectContext
    var manageItem : History! = nil

    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var ship: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if manageItem != nil {
            name.text = manageItem.name
            address.text = manageItem.address
            phone.text = manageItem.phone
            date.text = manageItem.date
            amount.text = manageItem.number
            price.text = manageItem.price
            ship.text = manageItem.ship
          
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
