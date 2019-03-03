//
//  Diet+CoreDataProperties.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 3/2/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//
//

import Foundation
import CoreData


extension Diet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Diet> {
        return NSFetchRequest<Diet>(entityName: "Diet")
    }

    @NSManaged public var name: String?
    @NSManaged public var part: String?
    @NSManaged public var channels: String?
    @NSManaged public var effect: String?
    @NSManaged public var flavour: String?
    @NSManaged public var nature: String?
    @NSManaged public var taoist: String?
    @NSManaged public var diet: String?

}
