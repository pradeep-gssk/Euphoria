//
//  Exercises+CoreDataProperties.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 3/4/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//
//

import Foundation
import CoreData


extension Exercises {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercises> {
        return NSFetchRequest<Exercises>(entityName: "Exercises")
    }

    @NSManaged public var videoName: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var videoDescription: String?
    @NSManaged public var videoUrl: URL?
    @NSManaged public var element: String?
    @NSManaged public var exercise: String?

}
