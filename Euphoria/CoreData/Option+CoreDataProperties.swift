//
//  Option+CoreDataProperties.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/10/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//
//

import Foundation
import CoreData


extension Option {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Option> {
        return NSFetchRequest<Option>(entityName: "Option")
    }

    @NSManaged public var index: Int16
    @NSManaged public var option: String?
    @NSManaged public var questionnaireOption: Questionnaire?
    @NSManaged public var questionnaireSubOption: Questionnaire?

}
