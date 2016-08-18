//
//  XMLPeopleParse.swift
//  player
//
//  Created by 杜鋆 on 29/02/2016.
//  Copyright © 2016 杜鋆. All rights reserved.
//

import UIKit


class XMLPeopleParse: NSObject, NSXMLParserDelegate {
    
    //variable declarations
    var fileName: String
    
    init(name:String){
        fileName = name
    }
    
    //vars to get the data from xml
    var pName, pAge,pPrice,pAmount, pDes, pNum,pClub,pCountry,pLatitude,pLongitude,pImage,pMarker,pUrl,pPositon,pReward: String!
    
    //vars to spy in between delegate methos
    var passData : Bool =  false
    var passElementId :Int = -1
    
    //var for parsing
    var parser = NSXMLParser()
    var person = Person()
    var people = [Person]()
    
    func beginParsing(){
        
        //get the fileName from the bundle
        let bundleUrl = NSBundle.mainBundle().bundleURL
        let fileUrl       = NSURL(string: fileName, relativeToURL: bundleUrl)
        
        
        //make the parse for this file
        parser = NSXMLParser(contentsOfURL: fileUrl!)!
        
        //set the selegate
        parser.delegate = self
        
        //parse
        parser.parse()
        
        
    }
    
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        //rest the spies if elementName is needed
        if(elementName == "name"
            || elementName == "age"
            || elementName == "price"
            || elementName == "amount"
            || elementName == "des"
            || elementName == "num"
            || elementName == "club"
            || elementName == "country"
            || elementName == "latitude"
            || elementName == "longitude"
            || elementName == "image"
            || elementName == "marker"
            || elementName == "url"
            || elementName == "position"
            || elementName == "reward"
            ){
            
            passData = false
            passElementId = -1
        }
        
        //make a new Person is </person>
        if elementName == "person"{
            person = Person(name: pName, age: pAge,price: pPrice,amount:pAmount, des: pDes, num: pNum,club: pClub,  country: pCountry, latitude: pLatitude, longitude: pLongitude, image: pImage, marker: pMarker,url: pUrl, position: pPositon, reward: pReward)
            people.append(person)
        }
    }
    
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        
        //spy what wlwmentName startwed
        if(elementName == "name"
            || elementName == "age"
            || elementName == "price"
            || elementName == "amount"
            || elementName == "des"
            || elementName == "num"
            || elementName == "club"
            || elementName == "country"
            || elementName == "latitude"
            || elementName == "longitude"
            || elementName == "image"
            || elementName == "marker"
            || elementName == "url"
            || elementName == "position"
            || elementName == "reward"){
            
            passData = true
            
            switch elementName {
                
            case "name" : passElementId=0
            case "age" : passElementId=1
            case "price" : passElementId=2
            case "amount" : passElementId=3
            case "des" : passElementId=4
            case "num" : passElementId=5
            case "club" : passElementId=6
            case "country" : passElementId=7
            case "latitude" : passElementId=8
            case "longitude" : passElementId=9
            case "image" : passElementId=10
            case "marker" : passElementId=11
            case "url" : passElementId=12
            case "position" : passElementId=13
            case "reward" : passElementId=14
          
                
            default : break
                
            }
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        //based on the spies then set the data vars
        
        if passData{
            switch passElementId{
            case 0 : pName = string
            case 1 : pAge = string
            case 2 : pPrice = string
            case 3 : pAmount = string
            case 4 : pDes = string
            case 5 : pNum = string
            case 6 : pClub = string
            case 7 : pCountry = string
            case 8 : pLatitude = string
            case 9 : pLongitude = string
            case 10 : pImage = string
            case 11 : pMarker = string
            case 12 : pUrl = string
            case 13 : pPositon = string
            case 14 : pReward = string
            default: break
                
                
            }
        }
        
    }
    
    
    
    
}
