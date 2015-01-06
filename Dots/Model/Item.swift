//
//  Item.swift
//  Dots
//
//  Created by knmsyk on 1/5/15.
//  Copyright (c) 2015 knmsyk. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
class Item: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var id: String
    @NSManaged var is_active: NSNumber
    @NSManaged var picture: String
    @NSManaged var text: String?
    @NSManaged var title: String?
    @NSManaged var url: String
    @NSManaged var entry: NSManagedObject
    @NSManaged var service: NSManagedObject

}
