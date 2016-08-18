//
//  People+CoreDataProperties.swift
//  CDpeople
//
//  Created by 杜鋆 on 07/03/2016.
//  Copyright © 2016 杜鋆. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Item {

    @NSManaged var price: String?
    @NSManaged var image: String?
    @NSManaged var amount: String?
    @NSManaged var name: String?

}
