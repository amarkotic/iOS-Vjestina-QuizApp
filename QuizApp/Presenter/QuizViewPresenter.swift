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
            guard let url = URL(string: "https://iosquiz.herokuapp.com/api/result") else{
                fatalError("URL not working")
            }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-type")
            request.addValue(token, forHTTPHeaderField: "Authorization")
            
            let json: [String : Any] = ["quiz_id": quizID, "user_id": userID, "time": time, "no_of_correct": numOfCorrect]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            request.httpBody = jsonData

            self.nService.executeTimePostUrlRequest(request) { (result: Result<String, TimePostError>) in
                
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
