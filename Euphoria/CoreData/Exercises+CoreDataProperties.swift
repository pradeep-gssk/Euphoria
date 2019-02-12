//
//  Exercises+CoreDataProperties.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/11/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//
//

import Foundation
import CoreData


extension Exercises {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercises> {
        return NSFetchRequest<Exercises>(entityName: "Exercises")
    }

    @NSManaged public var index: Int16
    @NSManaged public var title: String?
    @NSManaged public var exerciseVideo: NSSet?

}

// MARK: Generated accessors for exerciseVideo
extension Exercises {

    @objc(addExerciseVideoObject:)
    @NSManaged public func addToExerciseVideo(_ value: Video)

    @objc(removeExerciseVideoObject:)
    @NSManaged public func removeFromExerciseVideo(_ value: Video)

    @objc(addExerciseVideo:)
    @NSManaged public func addToExerciseVideo(_ values: NSSet)

    @objc(removeExerciseVideo:)
    @NSManaged public func removeFromExerciseVideo(_ values: NSSet)

}
