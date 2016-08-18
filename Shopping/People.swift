//
//  people.swift
//  player
//
//  Created by 杜鋆 on 29/02/2016.
//  Copyright © 2016 杜鋆. All rights reserved.
//

import UIKit

class People {
    
    var data : [Person]
    
    
    init(){
        
        
        data  = [
            
            Person(name: "Sabin", age: "lismore", price: "sd", amount:"sd" , des: "123643", num: "01/01/1952", club: "sabin.jpg",country: "Sabin", latitude: "lismore", longitude: "123643", image: "01/01/1952", marker: "sabin.jpg",url: "Sabin", position: "lismore", reward: "123643")
           
            
        ]
        
    }
    
    init(fromXMLFile: String){
        
        let parser = XMLPeopleParse(name: fromXMLFile)
        parser.beginParsing()
        
        data = parser.people
        
        
    }
    
}