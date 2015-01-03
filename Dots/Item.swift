//
//  Item.swift
//  Dots
//
//  Created by Kouno, Masayuki on 1/3/15.
//  Copyright (c) 2015 Kouno, Masayuki. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
class Item: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var text: String
    @NSManaged var url: String
    @NSManaged var date: NSDate
    @NSManaged var id: String
    @NSManaged var picture: String
    @NSManaged var service: NSManagedObject
    @NSManaged var entry: NSManagedObject

}
