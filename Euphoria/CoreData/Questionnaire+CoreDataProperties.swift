//
//  Questionnaire+CoreDataProperties.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/12/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//
//

import Foundation
import CoreData


extension Questionnaire {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Questionnaire> {
        return NSFetchRequest<Questionnaire>(entityName: "Questionnaire")
    }

    @NSManaged public var answer: String?
    @NSManaged public var details: String?
    @NSManaged public var index: Int16
    @NSManaged public var optionType: Int16
    @NSManaged public var question: String?
    @NSManaged public var subOptionType: Int16
    @NSManaged public var options: NSSet?
    @NSManaged public var questionnaires: Questionnaires?
    @NSManaged public var subOptions: NSSet?

}

// MARK: Generated accessors for options
extension Questionnaire {

    @objc(addOptionsObject:)
    @NSManaged public func addToOptions(_ value: Option)

    @objc(removeOptionsObject:)
    @NSManaged public func removeFromOptions(_ value: Option)

    @objc(addOptions:)
    @NSManaged public func addToOptions(_ values: NSSet)

    @objc(removeOptions:)
    @NSManaged public func removeFromOptions(_ values: NSSet)

}

// MARK: Generated accessors for subOptions
extension Questionnaire {

    @objc(addSubOptionsObject:)
    @NSManaged public func addToSubOptions(_ value: Option)

    @objc(removeSubOptionsObject:)
    @NSManaged public func removeFromSubOptions(_ value: Option)

    @objc(addSubOptions:)
    @NSManaged public func addToSubOptions(_ values: NSSet)

    @objc(removeSubOptions:)
    @NSManaged public func removeFromSubOptions(_ values: NSSet)

}
