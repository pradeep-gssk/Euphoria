//
//  Session+CoreDataProperties.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/12/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//
//

import Foundation
import CoreData


extension Session {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: "Session")
    }

    @NSManaged public var index: Int16
    @NSManaged public var name: String?
    @NSManaged public var time: Double
    @NSManaged public var stops: NSSet?

}

// MARK: Generated accessors for stops
extension Session {

    @objc(addStopsObject:)
    @NSManaged public func addToStops(_ value: Stop)

    @objc(removeStopsObject:)
    @NSManaged public func removeFromStops(_ value: Stop)

    @objc(addStops:)
    @NSManaged public func addToStops(_ values: NSSet)

    @objc(removeStops:)
    @NSManaged public func removeFromStops(_ values: NSSet)

}
