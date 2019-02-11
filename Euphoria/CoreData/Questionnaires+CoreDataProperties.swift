//
//  Questionnaires+CoreDataProperties.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/10/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//
//

import Foundation
import CoreData


extension Questionnaires {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Questionnaires> {
        return NSFetchRequest<Questionnaires>(entityName: "Questionnaires")
    }

    @NSManaged public var index: Int16
    @NSManaged public var state: Int16
    @NSManaged public var title: String?
    @NSManaged public var total: Int16
    @NSManaged public var questionnaire: NSSet?

}

// MARK: Generated accessors for questionnaire
extension Questionnaires {

    @objc(addQuestionnaireObject:)
    @NSManaged public func addToQuestionnaire(_ value: Questionnaire)

    @objc(removeQuestionnaireObject:)
    @NSManaged public func removeFromQuestionnaire(_ value: Questionnaire)

    @objc(addQuestionnaire:)
    @NSManaged public func addToQuestionnaire(_ values: NSSet)

    @objc(removeQuestionnaire:)
    @NSManaged public func removeFromQuestionnaire(_ values: NSSet)

}
