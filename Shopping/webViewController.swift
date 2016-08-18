//
//  webViewController.swift
//  player
//
//  Created by 杜鋆 on 04/03/2016.
//  Copyright © 2016 杜鋆. All rights reserved.
//

import UIKit

class webViewController: UIViewController {
 var person : Person!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(person.url)
        let url = NSURL (string: person.url);
        let requestObj = NSURLRequest(URL: url!);
        webview.loadRequest(requestObj);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var webview: UIWebView!
  

}
