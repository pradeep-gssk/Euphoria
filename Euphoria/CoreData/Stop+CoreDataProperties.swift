//
//  Stop+CoreDataProperties.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/12/19.
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
    @NSManaged public var resource: String?
    @NSManaged public var sound: String?
    @NSManaged public var time: Double
    @NSManaged public var type: String?
    @NSManaged public var session: Session?

}
