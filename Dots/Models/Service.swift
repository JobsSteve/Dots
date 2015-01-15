//
//  Service.swift
//  Dots
//
//  Created by Kouno, Masayuki on 1/7/15.
//  Copyright (c) 2015 Kouno, Masayuki. All rights reserved.
//

import Foundation
import CoreData

@objc(Service)
class Service: NSManagedObject {

    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var token: String
    @NSManaged var items: NSSet
    @NSManaged var users: NSSet

}
