//
//  QuizCoreDataSource.swift
//  QuizApp
//
//  Created by Antonio Markotic on 31.05.2021..
//

import CoreData

class QuizCoreDataSource: QuizCoreDataSourceProtocol{
 
    private let coreDataContext: NSManagedObjectContext

    init(coreDataContext: NSManagedObjectContext) {
        self.coreDataContext = coreDataContext
    }
    func saveNewQuizzesToCoreData(quizzes: [Quiz]){
      
        do {
            let newIds = quizzes.map { $0.id }
            try deleteAllQuizzesExcept(withId: newIds)
        }
        catch {
            print("Error when deleting quizzes from core data: \(error)")
        }

        
        quizzes.forEach { quiz in
            do {
                //popunjavanje kvizova u core date-i
                let cdQuiz = try fetchQuiz(withId: quiz.id) ?? CDQuiz(context: coreDataContext)
                    quiz.populate(cdQuiz, in: coreDataContext)
        
                //popunjavanje pitanja svakog kviza
                quiz.questions.forEach { question in
                    do {
                        let cdQuestion = try self.getQuestion(withId: question.id) ?? CDQuestion(context: self.coreDataContext)
                        question.populate(cdQuestion, in: self.coreDataContext)
                        cdQuiz.addToQuestions(cdQuestion)
                    } catch {
                        print("Error when fetching/creating a quiz: \(error)")
                    }
                }
            } catch {
                print("Error when fetching/creating a quiz: \(error)")
            }

            do {
                try coreDataContext.save()
            } catch {
                print("Error when saving updated quiz: \(error)")
            }
        }
  
    }
    
    

    func fetchAllQuizzesFromCoreData() -> [Quiz] {
        var quizzesFromCD : [Quiz] = []
        let request: NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
        
        
        
        
        do {
            quizzesFromCD =  try coreDataContext.fetch(request).map { Quiz(with: $0)
            }
        }catch{
            print("Error when fetching quizzes from core data: \(error)")
          
        }
  
        return quizzesFromCD
    }
    
    func fetchFilteredQuizzesFromCoreData(with name: String) -> [Quiz]{
        var quizzesFromCD : [Quiz] = []
        let request: NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
        var namePredicate = NSPredicate(value: true)
        
        if !name.isEmpty{
            namePredicate = NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(CDQuiz.title), name)
        }
        request.predicate = namePredicate
        
        
        
        do {
            quizzesFromCD =  try coreDataContext.fetch(request).map { Quiz(with: $0)
            }
        }catch{
            print("Error when fetching quizzes from core data: \(error)")
          
        }
  
        return quizzesFromCD
    }
    
    func fetchQuiz(withId id: Int) throws -> CDQuiz?{
        let request : NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %u", #keyPath(CDQuiz.identifier), id)
        let cdResponse = try coreDataContext.fetch(request)
        return cdResponse.first
    }
    
    
    
    private func getQuestion(withId id: Int) throws -> CDQuestion? {
        let request: NSFetchRequest<CDQuestion> = CDQuestion.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %u", #keyPath(CDQuestion.identifier), id)
        
        let cdResponse = try coreDataContext.fetch(request)
        return cdResponse.first
    }
    
    
    func deleteQuiz(withId id: Int){
        guard let quiz = try? fetchQuiz(withId: id) else{
            return
        }
        coreDataContext.delete(quiz)
        
        do{
            try coreDataContext.save()
        }catch{
            print("Error when saving after deletion of quizzes: \(error)")
        }
    }
    
    
    
    private func deleteAllQuizzesExcept(withId ids: [Int]) throws {
        let request: NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
        request.predicate = NSPredicate(format: "NOT %K IN %@", #keyPath(CDQuiz.identifier), ids)

        let quizzesToDelete = try coreDataContext.fetch(request)
        quizzesToDelete.forEach { coreDataContext.delete($0) }
        try coreDataContext.save()
    }
    
    
  
    
}
