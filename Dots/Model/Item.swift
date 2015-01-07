//
//  Item.swift
//  Dots
//
//  Created by Kouno, Masayuki on 1/7/15.
//  Copyright (c) 2015 Kouno, Masayuki. All rights reserved.
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
    @NSManaged var entry: Entry
    @NSManaged var service: Service
    @NSManaged var user: User?
    @NSManaged var cycle: Cycle

}
