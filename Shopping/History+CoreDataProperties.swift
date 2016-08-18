//
//  History+CoreDataProperties.swift
//  Shopping
//
//  Created by 杜鋆 on 31/03/2016.
//  Copyright © 2016 杜鋆. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension History {

    @NSManaged var name: String?
    @NSManaged var phone: String?
    @NSManaged var address: String?
    @NSManaged var price: String?
    @NSManaged var ship: String?
    @NSManaged var date: String?
    @NSManaged var number: String?
    @NSManaged var image: String?

}
