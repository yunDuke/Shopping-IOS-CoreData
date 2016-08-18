//
//  person.swift
//  player
//
//  Created by 杜鋆 on 29/02/2016.
//  Copyright © 2016 杜鋆. All rights reserved.
//

import UIKit

class Person{
    
    //properties
    var name   : String
    var age: String
    var price: String
    var amount: String
    var des  : String
    var num    : String
    var club  : String
    var country  : String
    var latitude  : String
    var longitude  : String
    var image  : String
    var marker  : String
    var url  : String
    var position  : String
    var reward  : String
    
    
    //init functions
    init()
    {
        self.name = "YUN DU"
        self.age = "121 Lismore Park"
        self.price = "sd"
        self.amount="ds"
        self.des = "824563 99999 "
        self.num = "12/2/1985"
        self.club = ""
        self.country = "YUN DU"
        self.latitude = "121 Lismore Park"
        self.longitude = "824563 99999 "
        self.image = "12/2/1985"
        self.marker = ""
        self.url = "YUN DU"
        self.position = "121 Lismore Park"
        self.reward = "824563 99999 "
      
    }
    
    
    init(name:String, age :String, price:String, amount:String,des:String, num:String, club:String,country :String, latitude:String, longitude:String, image:String,marker :String, url:String, position:String, reward:String)
    {
        self.name = name
        self.age = age
        self.price = price
        self.amount = amount
        self.des = des
        self.num = num
        self.club = club
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
        self.image = image
        self.marker = marker
        self.url = url
        self.position = position
        self.reward = reward
    }
}
