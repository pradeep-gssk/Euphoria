//
//  Videos+CoreDataProperties.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/12/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//
//

import Foundation
import CoreData


extension Videos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Videos> {
        return NSFetchRequest<Videos>(entityName: "Videos")
    }

    @NSManaged public var index: Int16
    @NSManaged public var title: String?
    @NSManaged public var video: NSSet?

}

// MARK: Generated accessors for video
extension Videos {

    @objc(addVideoObject:)
    @NSManaged public func addToVideo(_ value: Video)

    @objc(removeVideoObject:)
    @NSManaged public func removeFromVideo(_ value: Video)

    @objc(addVideo:)
    @NSManaged public func addToVideo(_ values: NSSet)

    @objc(removeVideo:)
    @NSManaged public func removeFromVideo(_ values: NSSet)

}
