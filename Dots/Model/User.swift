//
//  User.swift
//  Dots
//
//  Created by Kouno, Masayuki on 1/7/15.
//  Copyright (c) 2015 Kouno, Masayuki. All rights reserved.
//

import Foundation
import CoreData

@objc(User)
class User: NSManagedObject {

    @NSManaged var is_blocked: NSNumber
    @NSManaged var name: String
    @NSManaged var screen_name: String?
    @NSManaged var picture: String
    @NSManaged var url: String
    @NSManaged var id: String
    @NSManaged var service: Service
    @NSManaged var items: NSSet

}
