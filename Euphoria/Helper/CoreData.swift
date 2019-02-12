//
//  CoreData.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/9/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import CoreData

class CoreData: NSObject {
    static let sharedInstance = CoreData()
    let context = appDelegate.persistentContainer.viewContext
}

//MARK: Questionnaires
extension CoreData {
    func saveQuestionnaire(_ json: [String: AnyObject], forIndex index: Int16, withTotal total: Int16) {
        let questionnaires = NSEntityDescription.insertNewObject(forEntityName: "Questionnaires", into: context) as? Questionnaires
        questionnaires?.title = json["title"] as? String
        questionnaires?.state = 0
        questionnaires?.index = index
        questionnaires?.total = total
        if let questionnaireList = json["questionnaire"] as? [[String: AnyObject]] {
            for questionnaire in questionnaireList {
                if let response = self.setQuestionnaire(questionnaire) {
                    questionnaires?.addToQuestionnaire(response)
                }
            }
        }
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func setQuestionnaire(_ json: [String: AnyObject]) -> Questionnaire? {
        let questionnaire = NSEntityDescription.insertNewObject(forEntityName: "Questionnaire", into: context) as? Questionnaire
        questionnaire?.answer = nil
        questionnaire?.details = nil
        questionnaire?.index = json["index"] as? Int16 ?? 0
        questionnaire?.optionType = json["optionType"] as? Int16 ?? 0
        questionnaire?.subOptionType = json["subOptionType"] as? Int16 ?? 0
        questionnaire?.question = json["question"] as? String
        
        if let options = json["options"] as? [[String: AnyObject]] {
            for option in options {
                if let response = self.setOptions(option) {
                    questionnaire?.addToOptions(response)
                }
            }
        }
        
        return questionnaire
    }
    
    func setOptions(_ json: [String: AnyObject]) -> Option? {
        let options = NSEntityDescription.insertNewObject(forEntityName: "Option", into: context) as? Option
        options?.option = json["option"] as? String
        options?.index = json["index"] as? Int16 ?? 0
        return options
    }
    
    func fetchQuestionnaire(forIndex index: Int16) -> Questionnaires? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Questionnaires.self))
        fetchRequest.predicate = NSPredicate(format: "index = \(NSNumber(value:index))")
        do {
            let data = try context.fetch(fetchRequest) as? [Questionnaires]
            return data?.first
            
        } catch {
            return nil
        }
    }
    
    func updateAnswer(_ object: Questionnaire, string: String?) {
        object.answer = string
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func updateDetails(_ object: Questionnaire, details: String?) {
        object.details = details
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func updateState(_ object: Questionnaires, state: Int16) {
        object.state = state
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}

//MARK: Exercises
extension CoreData {
    func saveExercises(_ json: [[String: AnyObject]]) {
        for dictionary in json {
            let exercises = NSEntityDescription.insertNewObject(forEntityName: "Exercises", into: context) as? Exercises
            exercises?.title = dictionary["title"] as? String
            exercises?.index = dictionary["index"] as? Int16 ?? 0
            if let videos = dictionary["videos"] as? [[String: AnyObject]] {
                for video in videos {
                    if let response = self.setVideo(video) {
                        exercises?.addToExerciseVideo(response)
                    }
                }
            }
        }
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func setVideo(_ json: [String: AnyObject]) -> Video? {
        let exerciseVideo = NSEntityDescription.insertNewObject(forEntityName: "Video", into: context) as? Video
        exerciseVideo?.title = json["title"] as? String
        exerciseVideo?.videoDescription = json["video_description"] as? String
        exerciseVideo?.videoName = json["video_name"] as? String
        if let string = json["video_url"] as? String {
            exerciseVideo?.videoUrl = URL(string: string)
        }
        return exerciseVideo
    }
    
    func fetchExercises() -> [Exercises] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Exercises.self))
        let sortDescriptor = NSSortDescriptor(key: "index", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let data = try context.fetch(fetchRequest) as? [Exercises]
            return data ?? []
            
        } catch {
            return []
        }
    }
}

//MARK: Sound
extension CoreData {
    func saveSound(_ json: [[String: String]]) {
        for dictionary in json {
            let sound = NSEntityDescription.insertNewObject(forEntityName: "Sound", into: context) as? Sound
            sound?.name = dictionary["name"]
            sound?.resource = dictionary["resource"]
            sound?.type = dictionary["type"]
            sound?.path = Bundle.main.path(forResource: dictionary["resource"], ofType: dictionary["type"])
        }
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func fetchSounds() -> [Sound] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Sound.self))
        do {
            let data = try context.fetch(fetchRequest) as? [Sound]
            return data ?? []
            
        } catch {
            return []
        }
    }
}

//MARK: Session
extension CoreData {
    func fetchSessions() -> [Session] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Session.self))
        do {
            let data = try context.fetch(fetchRequest) as? [Session]
            return data ?? []
            
        } catch {
            return []
        }
    }
    
    func saveSession() {
//        let sound = NSEntityDescription.insertNewObject(forEntityName: "Session", into: context) as? Session
    }
}
