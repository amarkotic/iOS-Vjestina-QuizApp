//
//  CDQuestion+CoreDataProperties.swift
//  
//
//  Created by Antonio Markotic on 05.06.2021..
//
//

import Foundation
import CoreData


extension CDQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDQuestion> {
        return NSFetchRequest<CDQuestion>(entityName: "CDQuestion")
    }

    @NSManaged public var answers: NSObject?
    @NSManaged public var correctAnswer: Int32
    @NSManaged public var identifier: Int32
    @NSManaged public var question: String?
    @NSManaged public var quiz: CDQuiz?

}
