//
//  Sound+CoreDataProperties.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/11/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//
//

import Foundation
import CoreData


extension Sound {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sound> {
        return NSFetchRequest<Sound>(entityName: "Sound")
    }

    @NSManaged public var name: String?
    @NSManaged public var resource: String?
    @NSManaged public var type: String?
    @NSManaged public var path: String?

}
