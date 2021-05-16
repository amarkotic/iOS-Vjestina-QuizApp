//
//  LeaderboardPresenter.swift
//  QuizApp
//
//  Created by Antonio Markotic on 16.05.2021..
//

import Foundation
class LeaderboardPresenter{
    private let nService : NetworkService
    weak private var leaderboardViewDelegate : LeaderboardViewController?
    let defaults = UserDefaults()
    
    init(networking: NetworkService){
        self.nService = networking
    }
    func setLeaderboardViewDelegate(leaderboardViewDelegate : LeaderboardViewController?){
        self.leaderboardViewDelegate = leaderboardViewDelegate
    }
    
    func fetchLeaderboard(){
        
        DispatchQueue.global().async {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "iosquiz.herokuapp.com"
            urlComponents.path = "/api/score"
            
            
            let queryItems = [URLQueryItem(name: "quiz_id", value: self.defaults.string(forKey: "quizID"))]
            urlComponents.queryItems = queryItems
            var request = URLRequest(url: urlComponents.url!)
            
            
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-type")
            request.addValue(self.defaults.string(forKey: "token")!, forHTTPHeaderField: "Authorization")
            
            
            self.nService.executeUrlRequest(request) { (result: Result<[LeaderboardResult], RequestError>) in
                
                switch result{
                case .failure(let error):
                    print(error)
                    
                case .success(let value):
                    self.leaderboardViewDelegate?.populateList(recievedList: value)
                }
            }
        }
    }
}
