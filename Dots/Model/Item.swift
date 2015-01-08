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

    @NSManaged var id: String
    @NSManaged var is_active: NSNumber
    @NSManaged var picture: String
    @NSManaged var text: String?
    @NSManaged var title: String?
    @NSManaged var url: String
    @NSManaged var created_at: NSDate
    @NSManaged var cycle: Cycle
    @NSManaged var entry: Entry
    @NSManaged var service: Service
    @NSManaged var user: User?

    var date: String {
        get{
            let key = "date"
            self.willAccessValueForKey(key)
            var date: String? = self.primitiveValueForKey(key) as? String
            self.didAccessValueForKey(key)
            
            if date == nil {
                date = Utility.stringFromDate("yyyy.MM.dd.eee", date: self.created_at)
                self.setPrimitiveValue(date, forKey: key)
            }
            
            return date!
        }
    }
}
