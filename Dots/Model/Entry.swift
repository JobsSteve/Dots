//
//  Entry.swift
//  Dots
//
//  Created by Kouno, Masayuki on 1/7/15.
//  Copyright (c) 2015 Kouno, Masayuki. All rights reserved.
//

import Foundation
import CoreData

@objc(Entry)
class Entry: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var type: NSNumber
    @NSManaged var items: NSSet

}
