//
//  Video+CoreDataProperties.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/11/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//
//

import Foundation
import CoreData


extension Video {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Video> {
        return NSFetchRequest<Video>(entityName: "Video")
    }

    @NSManaged public var title: String?
    @NSManaged public var videoDescription: String?
    @NSManaged public var videoName: String?
    @NSManaged public var videoUrl: URL?
    @NSManaged public var exercises: Exercises?

}
