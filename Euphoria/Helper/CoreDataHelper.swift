//
//  CoreData.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/9/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import CoreData

class CoreDataHelper: NSObject {
    static let shared = CoreDataHelper()
    let context = appDelegate.persistentContainer.viewContext
    
    func setVideo(_ json: [String: AnyObject]) -> Video? {
        let video = NSEntityDescription.insertNewObject(forEntityName: "Video", into: context) as? Video
        video?.title = json["title"] as? String
        video?.videoDescription = json["video_description"] as? String
        video?.videoName = json["video_name"] as? String
        video?.thumbnail = json["thumbnail"] as? String
        if let string = json["video_url"] as? String {
            video?.videoUrl = URL(string: string)
        }
        return video
    }
}

//MARK: Loading
extension CoreDataHelper {
    
    func preloadQuestionnaires(customerId: Int64) {
        self.loadQuestionnaire(withResource: "Questionnaire1", forIndex: 1, forCustomer: customerId)
        self.loadQuestionnaire(withResource: "Questionnaire2", forIndex: 2, forCustomer: customerId)
        self.loadQuestionnaire(withResource: "Questionnaire3", forIndex: 3, forCustomer: customerId)
        self.loadQuestionnaire(withResource: "Questionnaire4", forIndex: 4, forCustomer: customerId)
        self.loadQuestionnaire(withResource: "Questionnaire5", forIndex: 5, forCustomer: customerId)
    }
    
    func preloadData() {
        self.loadExercises(withResource: "Exercises")
        self.loadSounds(withResource: "Sounds")
        self.loadVideos(withResource: "Videos")
        self.loadDiet(withResource: "Diet")
    }
    
    private func loadQuestionnaire(withResource resource: String, forIndex index: Int16, forCustomer customerId: Int64, update: Bool = false) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [String: AnyObject] {
                    if update == true {
                        self.updateQuestionnaire(jsonResult, forIndex: index, forCustomer: customerId)
                    }
                    else {
                        self.saveQuestionnaire(jsonResult, forIndex: index, forCustomer: customerId)
                    }
                }
            } catch {
                // handle error
            }
        }
    }
    
    private func loadExercises(withResource resource: String) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String: AnyObject]] {
                    self.saveExercises(jsonResult)
                }
            } catch {
                print(error)
                // handle error
            }
        }
    }
    
    private func loadSounds(withResource resource: String) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String: String]] {
                    self.saveSound(jsonResult)
                }
            } catch {
                print(error)
                // handle error
            }
        }
    }
    
    private func loadVideos(withResource resource: String) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String: AnyObject]] {
                    self.saveVideos(jsonResult)
                }
            } catch {
                print(error)
                // handle error
            }
        }
    }
    
    private func loadDiet(withResource resource: String) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String: AnyObject]] {
                    self.saveDiet(jsonResult)
                }
            } catch {
                print(error)
                // handle error
            }
        }
    }
}

//MARK: User
extension CoreDataHelper {
    func saveUser(_ customerId: Int64) {
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User
        user?.customerId = customerId
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func checkIfUserDoesntExist(_ customerId: Int64) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: User.self))
        fetchRequest.predicate = NSPredicate(format: "customerId = \(NSNumber(value: customerId))")
        do {
            if let data = try context.fetch(fetchRequest) as? [User] {
                return (data.count > 0) ? false : true
            }
        } catch {
        }
        return false
    }
}

//MARK: Questionnaires
extension CoreDataHelper {
    func saveQuestionnaire(_ json: [String: AnyObject], forIndex index: Int16, forCustomer customerId: Int64) {
        let questionnaires = NSEntityDescription.insertNewObject(forEntityName: "Questionnaires", into: context) as? Questionnaires
        questionnaires?.title = json["title"] as? String
        questionnaires?.state = 0
        questionnaires?.total = 0
        questionnaires?.index = index
        questionnaires?.customerId = customerId
        if let questionnaireList = json["questionnaire"] as? [[String: AnyObject]] {
            questionnaires?.total = Int16(questionnaireList.count)
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
        questionnaire?.element = json["element"] as? String
        questionnaire?.index = json["index"] as? Int16 ?? 0
        questionnaire?.colorIndex = json["colorIndex"] as? Int16 ?? 0
        questionnaire?.optionType = json["optionType"] as? Int16 ?? 0
        questionnaire?.subOptionType = json["subOptionType"] as? Int16 ?? 0
        questionnaire?.question = json["question"] as? String
        questionnaire?.selectionType = json["selectionType"] as? Int16 ?? 0

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
    
    func fetchQuestionnaire(forIndex index: Int16, _ customerId: Int64) -> Questionnaires? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Questionnaires.self))
        fetchRequest.predicate = NSPredicate(format: "(index = \(NSNumber(value:index))) AND (customerId = \(NSNumber(value:customerId)))")
        do {
            let data = try context.fetch(fetchRequest) as? [Questionnaires]
            return data?.first
            
        } catch {
            return nil
        }
    }
    
    func checkIfAllAnswered(forIndex index: Int16, _ customerId: Int64) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Questionnaire.self))
        let otherOptions = "(((optionType = \(NSNumber(value: 0))) OR (optionType = \(NSNumber(value: 1)))) AND (answer = nil))"
        let option2 = "((optionType = \(NSNumber(value: 2))) AND (answer = nil) AND (details = nil))"
        let predicateString = "(\(otherOptions) OR \(option2)) AND (questionnaires.index = \(NSNumber(value: index))) AND (questionnaires.customerId = \(NSNumber(value:customerId)))"
        fetchRequest.predicate = NSPredicate(format: predicateString)
        do {
            if let data = try context.fetch(fetchRequest) as? [Questionnaire] {
                return (data.count > 0) ? false : true
            }
        } catch {
        }
        return false
    }
    
    func fetchAnsweredQuestionnaire(_ customerId: Int64) -> [Questionnaire]  {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Questionnaire.self))
        let otherOptions = "(((optionType = \(NSNumber(value: 0))) OR (optionType = \(NSNumber(value: 1)))) AND (answer != nil))"
        let option2 = "((optionType = \(NSNumber(value: 2))) AND ((answer != nil) OR (details != nil)))"
        let predicateString = "(\(otherOptions) OR \(option2)) AND (questionnaires.customerId = \(NSNumber(value:customerId)))"
        fetchRequest.predicate = NSPredicate(format: predicateString)
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "questionnaires.index", ascending: true),
                                        NSSortDescriptor(key: "index", ascending: true)]
        do {
            let data = try context.fetch(fetchRequest) as? [Questionnaire]
            return data ?? []
        } catch {
        }
        
        return []
    }
    
    func clearAllAnswers(_ customerId: Int64) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Questionnaire.self))
        fetchRequest.predicate = NSPredicate(format: "questionnaires.customerId = \(NSNumber(value:customerId))")

        do {
            if let questionnaires = try context.fetch(fetchRequest) as? [Questionnaire] {
                for questionnaire in questionnaires {
                    questionnaire.answer = nil
                    questionnaire.details = nil
                }
            }
            
            try context.save()
        } catch {
        }
    }
    
    func getElementCount(forString element: String, _ customerId: Int64) -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Questionnaire.self))
        fetchRequest.predicate = NSPredicate(format: "(answer = %@) AND (element = %@)  AND (questionnaires.customerId = %@)", "Yes", element, NSNumber(value:customerId))
        
        do {
            if let data = try context.fetch(fetchRequest) as? [Questionnaire] {
                return data.count
            }
        } catch {
        }
        
        return 0
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
    
    func fetchAllQuestionnaires(_ customerId: Int64) -> [Questionnaires] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Questionnaires.self))
        fetchRequest.predicate = NSPredicate(format: "customerId = %@", NSNumber(value:customerId))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "index", ascending: true)]
        do {
            let data = try context.fetch(fetchRequest) as? [Questionnaires]
            return data ?? []
        } catch {
        }

        return []
    }
}

//MARK: Exercises
extension CoreDataHelper {
    func saveExercises(_ json: [[String: AnyObject]]) {
        for dictionary in json {
            let exercise = NSEntityDescription.insertNewObject(forEntityName: "Exercises", into: context) as? Exercises
            exercise?.videoName = dictionary["video_name"] as? String
            exercise?.thumbnail = dictionary["thumbnail"] as? String
            exercise?.videoDescription = dictionary["video_description"] as? String
            if let string = dictionary["video_url"] as? String {
                exercise?.videoUrl = URL(string: string)
            }
            exercise?.element = dictionary["element"] as? String
            exercise?.exercise = dictionary["exercise"] as? String
        }
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func fetchExerciseforElement(_ element: String, exercise: String) -> [Exercises] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Exercises.self))
        let sortDescriptor = NSSortDescriptor(key: "videoName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "(element = %@) AND (exercise = %@)", element, exercise)
        
        do {
            let data = try context.fetch(fetchRequest) as? [Exercises]
            return data ?? []
            
        } catch {
            return []
        }
    }
    
    func fetchUniqueExercises(_ element: String) -> [String] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Exercises.self))
        fetchRequest.predicate = NSPredicate(format: "element = %@", element)
        fetchRequest.propertiesToFetch = ["exercise"]
        fetchRequest.resultType = .dictionaryResultType
        fetchRequest.returnsDistinctResults = true
        
        do {
            if let data = try context.fetch(fetchRequest) as? [[String: String]] {
                var array: [String] = []
                for dict in data {
                    array.append(contentsOf: dict.values)
                }
                return array
            }
            
        } catch {
        }
        return []
    }
}

//MARK: Videos
extension CoreDataHelper {
    func saveVideos(_ json: [[String: AnyObject]]) {
        for dictionary in json {
            let videoObject = NSEntityDescription.insertNewObject(forEntityName: "Videos", into: context) as? Videos
            videoObject?.title = dictionary["title"] as? String
            videoObject?.index = dictionary["index"] as? Int16 ?? 0
            if let videos = dictionary["videos"] as? [[String: AnyObject]] {
                for video in videos {
                    if let response = self.setVideo(video) {
                        videoObject?.addToVideo(response)
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
    
    func fetchVideos() -> [Videos] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Videos.self))
        let sortDescriptor = NSSortDescriptor(key: "index", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let data = try context.fetch(fetchRequest) as? [Videos]
            return data ?? []
            
        } catch {
            return []
        }
    }
}

//MARK: Sound
extension CoreDataHelper {
    func saveSound(_ json: [[String: String]]) {
        for dictionary in json {
            let sound = NSEntityDescription.insertNewObject(forEntityName: "Sound", into: context) as? Sound
            sound?.name = dictionary["name"]
            sound?.resource = dictionary["resource"]
            sound?.type = dictionary["type"]
        }
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func fetchSounds() -> [Sound] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Sound.self))
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let data = try context.fetch(fetchRequest) as? [Sound]
            return data ?? []
            
        } catch {
            return []
        }
    }
    
    func firstSound() -> Sound? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Sound.self))
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let data = try context.fetch(fetchRequest) as? [Sound]
            return data?.first ?? nil
            
        } catch {
            return nil
        }
    }
}

//MARK: Session
extension CoreDataHelper {
    func fetchSessions(_ customerId: Int64) -> [Session] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Session.self))
        fetchRequest.predicate = NSPredicate(format: "customerId = %@", NSNumber(value: customerId))
        let sortDescriptor = NSSortDescriptor(key: "index", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let data = try context.fetch(fetchRequest) as? [Session]
            return data ?? []
            
        } catch {
            return []
        }
    }
    
    func saveSession(_ sessionObject: EUSession, _ customerId: Int64) {
        let session = NSEntityDescription.insertNewObject(forEntityName: "Session", into: context) as? Session
        session?.name = sessionObject.name
        session?.index = sessionObject.index
        session?.time = sessionObject.time
        session?.customerId = customerId
        
        for i in 0..<sessionObject.stops.count {
            let stop = sessionObject.stops[i]
            let sound = sessionObject.sounds[i]
            if let response = self.saveStop(stop, sound: sound) {
                session?.addToStops(response)
            }
        }
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func saveStop(_ stopObject: EUStop, sound: Sound) -> Stop? {
        let stop = NSEntityDescription.insertNewObject(forEntityName: "Stop", into: context) as? Stop
        stop?.index = stopObject.index
        stop?.time = stopObject.time
        stop?.sound = sound.name
        stop?.resource = sound.resource
        stop?.type = sound.type
        return stop
    }
    
    func deleteSession(_ session: Session) {
        context.delete(session)
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}

//MARK: Diet
extension CoreDataHelper {
    func saveDiet(_ json: [[String: AnyObject]]) {
        for dictionary in json {
            let dietObject = NSEntityDescription.insertNewObject(forEntityName: "Diet", into: context) as? Diet
            dietObject?.name = dictionary["name"] as? String
            dietObject?.organ = dictionary["organ"] as? String
            dietObject?.channels = dictionary["channels"] as? String
            dietObject?.effect = dictionary["effect"] as? String
            dietObject?.flavour = dictionary["flavour"] as? String
            dietObject?.nature = dictionary["nature"] as? String
            dietObject?.element = dictionary["element"] as? String
            dietObject?.diet = dictionary["diet"] as? String
        }
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func fetchDietforElement(_ element: String, diet: String) -> [Diet] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Diet.self))
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "(element = %@) AND (diet = %@)", element, diet)

        do {
            let data = try context.fetch(fetchRequest) as? [Diet]
            return data ?? []
            
        } catch {
            return []
        }
    }
    
    func fetchUniqueDiets(_ element: String) -> [String] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Diet.self))
        fetchRequest.predicate = NSPredicate(format: "element = %@", element)
        fetchRequest.propertiesToFetch = ["diet"]
        fetchRequest.resultType = .dictionaryResultType
        fetchRequest.returnsDistinctResults = true
        
        do {
            if let data = try context.fetch(fetchRequest) as? [[String: String]] {
                var array: [String] = []
                for dict in data {
                    array.append(contentsOf: dict.values)
                }
                return array
            }
            
        } catch {
        }
        return []
    }
}

//MARK: History
extension CoreDataHelper {
    
    func fetchHistory(_ imageType: String, _ customerId: Int64) -> [History] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: History.self))
        fetchRequest.predicate = NSPredicate(format: "(imageType = %@) AND (customerId = %@)", imageType, NSNumber(value: customerId))
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let data = try context.fetch(fetchRequest) as? [History]
            return data ?? []
            
        } catch {
            return []
        }
    }
    
    func saveHistory(_ date: NSDate, name: String, imageType: String, customerId: Int64) {
        let history = NSEntityDescription.insertNewObject(forEntityName: "History", into: context) as? History
        history?.date = date
        history?.fileName = name
        history?.imageType = imageType
        history?.customerId = customerId
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func deleteHistory(_ history: History) {
        context.delete(history)
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}

//MARK: Update
extension CoreDataHelper {
    func updateAll() {
        let customers = fetchUniqueCustomerId()
        for customerId in customers {
            self.loadQuestionnaire(withResource: "Questionnaire1", forIndex: 1, forCustomer: customerId, update: true)
            self.loadQuestionnaire(withResource: "Questionnaire2", forIndex: 2, forCustomer: customerId, update: true)
            self.loadQuestionnaire(withResource: "Questionnaire3", forIndex: 3, forCustomer: customerId, update: true)
            self.loadQuestionnaire(withResource: "Questionnaire4", forIndex: 4, forCustomer: customerId, update: true)
            self.loadQuestionnaire(withResource: "Questionnaire5", forIndex: 5, forCustomer: customerId, update: true)
        }
        
//        self.deleteOthers()
//        self.loadExercises(withResource: "Exercises")
//        self.loadVideos(withResource: "Videos")
//        self.loadDiet(withResource: "Diet")
    }
    
    private func fetchUniqueCustomerId() -> [Int64] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Questionnaires.self))
        fetchRequest.propertiesToFetch = ["customerId"]
        fetchRequest.resultType = .dictionaryResultType
        fetchRequest.returnsDistinctResults = true
        
        do {
            if let data = try context.fetch(fetchRequest) as? [[String: Int64]] {
                var array: [Int64] = []
                for dict in data {
                    array.append(contentsOf: dict.values)
                }
                return array
            }
            
        } catch {
        }
        return []
    }
    
    private func updateQuestionnaire(_ json: [String: AnyObject], forIndex index: Int16, forCustomer customerId: Int64) {
        
        if let questionnaireList = json["questionnaire"] as? [[String: AnyObject]],
            let questionnaire = self.fetchQuestionnaire(forIndex: index, customerId) {
            
            if questionnaire.total != Int16(questionnaireList.count) {
                questionnaire.total = Int16(questionnaireList.count)
            }
            
            let newIndexes = questionnaireList.filter({$0["index"] != nil}).map({$0["index"] as? Int16 ?? 0})
            let questionnaires = questionnaire.questionnaire?.allObjects as? [Questionnaire] ?? []
            let currentIndexes = questionnaires.map({$0.index})
            let uniqueValues = Set(newIndexes).symmetricDifference(currentIndexes)
            if uniqueValues.count > 0 {
                for value in uniqueValues {
                    if newIndexes.contains(value) {
                        let newQuestionnaires = questionnaireList.filter{($0["index"] as? Int16) == value}
                        for newQuestionnaire in newQuestionnaires {
                            if let response = self.setQuestionnaire(newQuestionnaire) {
                                questionnaire.addToQuestionnaire(response)
                            }
                        }
                    }
                    else if currentIndexes.contains(value) {
                        let oldQuestionnaires = questionnaires.filter{$0.index == value}
                        for oldQuestionnaire in oldQuestionnaires {
                            questionnaire.removeFromQuestionnaire(oldQuestionnaire)
                            context.delete(oldQuestionnaire)
                        }
                    }
                }
                
                do {
                    try context.save()
                } catch {
                    print("Failed saving")
                }
            }
        }
    }
    
    private func deleteOthers() {
        self.deleteExercises()
        self.deleteVideos()
        self.deleteDiet()
    }
    
    private func deleteExercises() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Exercises.self))
        do {
            let exercises = try context.fetch(fetchRequest) as? [Exercises] ?? []
            for exercise in exercises {
                context.delete(exercise)
            }
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    private func deleteVideos() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Videos.self))
        do {
            let videos = try context.fetch(fetchRequest) as? [Videos] ?? []
            for entity in videos {
                let childEntities = entity.video?.allObjects as? [NSManagedObject] ?? []
                for video in childEntities {
                    context.delete(video)
                }
                context.delete(entity)
            }
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    private func deleteDiet() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Diet.self))
        do {
            let diets = try context.fetch(fetchRequest) as? [Diet] ?? []
            for diet in diets {
                context.delete(diet)
            }
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}
