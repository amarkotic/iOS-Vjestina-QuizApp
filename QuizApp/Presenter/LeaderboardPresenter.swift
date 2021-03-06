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
        
      
        let request = nService.fetchLeaderboardFromNetwork()
            
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
