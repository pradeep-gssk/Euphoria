//
//  Stop+CoreDataProperties.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/11/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//
//

import Foundation
import CoreData


extension Stop {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stop> {
        return NSFetchRequest<Stop>(entityName: "Stop")
    }

    @NSManaged public var index: Int16
    @NSManaged public var sound: String?
    @NSManaged public var path: String?
    @NSManaged public var time: Double
    @NSManaged public var session: Session?

}
