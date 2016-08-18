//
//  DetailViewController.swift
//  player
//
//  Created by 杜鋆 on 29/02/2016.
//  Copyright © 2016 杜鋆. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var reward: UITextView!

    @IBOutlet weak var career: UITextView!
    @IBOutlet weak var des: UITextView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var club: UILabel!
    @IBOutlet weak var country: UILabel!
    var person : Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = person.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        //person is pushed
        
        //setup the outlets
        if person != nil{
       images.image = UIImage(named: person.image)
            address.text = person.age
            dob.text = person.position
            phone.text = person.num
            club.text = person.club
            country.text = person.country
            des.text = person.des
            career!.text = person.reward
        }
        
    }

   

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
            if segue.identifier == "segue3" {
                let controller = segue.destinationViewController as! webViewController
                controller.person = self.person
                
            }

           
        }

       


}
