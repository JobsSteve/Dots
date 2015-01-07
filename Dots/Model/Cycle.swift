//
//  Cycle.swift
//  Dots
//
//  Created by Kouno, Masayuki on 1/7/15.
//  Copyright (c) 2015 Kouno, Masayuki. All rights reserved.
//

import Foundation
import CoreData

@objc(Cycle)
class Cycle: NSManagedObject {

    @NSManaged var day: NSNumber
    @NSManaged var items: NSSet

}
