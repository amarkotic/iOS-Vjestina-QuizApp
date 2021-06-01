//
//  Quiz+CD.swift
//  QuizApp
//
//  Created by Antonio Markotic on 30.05.2021..
//

import CoreData

extension Quiz {
    
    init(with entity: CDQuiz){
        id = Int(entity.identifier)
        title = entity.title!
        description = entity.desc!
        category =  QuizCategory(rawValue: entity.category!)!
       
        level = Int(entity.level)
        imageUrl = entity.imageUrl!
        questions = []
        self.populateQuestions(questions: entity.questions?.allObjects as! [CDQuestion])
        
    }
    mutating func populateQuestions(questions: [CDQuestion]){
        questions.forEach{ question in
            let newQuestion = Question(with: question)
            self.questions.append(newQuestion)
        }
    }
  
       
    
    func populate(_ entity: CDQuiz,in context: NSManagedObjectContext){

        entity.identifier = Int32(id)
        entity.title = title
        entity.desc = description
        entity.category = category.rawValue
        entity.level = Int32(level)
        entity.imageUrl = imageUrl
        //populiranje questiona je odradeno custom funkcijom u QuizCoreDataSource
    }
}
