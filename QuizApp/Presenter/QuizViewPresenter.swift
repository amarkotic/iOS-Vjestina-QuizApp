//
//  QuizViewPresenter.swift
//  QuizApp
//
//  Created by Antonio Markotic on 16.05.2021..
//

import Foundation
class QuizViewPresenter{
    private let nService : NetworkService
    weak private var quizViewDelegate : QuizViewController?

    
    init(networking: NetworkService){
        self.nService = networking
    }
    func setQuizViewDelegate(quizViewDelegate : QuizViewController?){
        self.quizViewDelegate = quizViewDelegate
    }
    
    
    
    func postResult(quizID: Int, userID: Int, time: Double, numOfCorrect: Int, token: String){
        DispatchQueue.global().async {
            let request = self.nService.fetchQuiz(quizID: quizID, userID: userID, time: time, numOfCorrect: numOfCorrect, token: token)

            self.nService.executeTimePostUrlRequest(request) { (result: Result<String, TimePostError>) in
                
                //ne 
                switch result{
                case .failure(let error):
                    print(error)

                case .success(let value):
                    print(value)
                }
            }
            
        }
        
    }
    
   
}
