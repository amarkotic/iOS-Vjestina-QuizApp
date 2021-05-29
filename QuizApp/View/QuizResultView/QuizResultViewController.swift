//
//  QuizResultViewController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 07.05.2021..
//

import UIKit

class QuizResultViewController: UIViewController {

    var numOfCorrectAnswers = 0
    var totalNumOfQuestions = 0
    var scoreLabel = UILabel()
    let finishButton = UIButton()
    let seeLeaderBoardButton = UIButton()
    
    
    private var router: AppRouter!
    convenience init(router: AppRouter) {
        self.init()
        self.router = router
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UI
        buildViews()
      
        //funkcionalnost
        finishButton.addTarget(self, action: #selector(finishQuiz), for: .touchUpInside)
        seeLeaderBoardButton.addTarget(self, action: #selector(seeLeaderBoard), for: .touchUpInside)
    }
   

    func set (numOfCorrect:Int, numOfQuestions:Int){
        numOfCorrectAnswers = numOfCorrect
        totalNumOfQuestions = numOfQuestions
    }
   
    
    
    @objc func finishQuiz(){
        router.popToRoot()
    }
    
    
    @objc func seeLeaderBoard(){
        router.showLeaderboard()
    }
}
