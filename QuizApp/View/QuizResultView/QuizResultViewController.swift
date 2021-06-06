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


//Animations
extension QuizResultViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scoreLabel.transform = scoreLabel.transform.scaledBy(x: 0, y: 0)
        seeLeaderBoardButton.transform = seeLeaderBoardButton.transform.translatedBy(x: -view.frame.width, y: 0)
        finishButton.transform = finishButton.transform.translatedBy(x: view.frame.width, y: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: { [self] in
                        scoreLabel.alpha = 1
                        scoreLabel.transform = .identity
                        self.view.layoutIfNeeded()
                       }
        )
        
        UIView.animate(withDuration: 1.5,
                       delay: 1.0,
                       options: [.curveEaseInOut],
                       animations: { [self] in
                        seeLeaderBoardButton.transform = .identity
                        self.view.layoutIfNeeded()
                       }
        )
        
        UIView.animate(withDuration: 1.5,
                       delay: 1.0,
                       options: [.curveEaseInOut],
                       animations: { [self] in
                       
                        finishButton.transform = .identity
                        self.view.layoutIfNeeded()
                       }
        )
        
//
//        UIView.animate(withDuration: 1.5,
//                       delay: 0.25,
//                       options: [.curveEaseInOut],
//                       animations: { [self] in
//                        seeLeaderBoardButton.alpha = 1
//                        seeLeaderBoardButton.transform = .identity
//                        self.view.layoutIfNeeded()
//                       }
//        )
//
//        UIView.animate(withDuration: 1.5,
//                       delay: 0.5,
//                       options: [.curveEaseInOut],
//                       animations: { [self] in
//                        passwordTextField.alpha = 1
//                        passwordTextField.transform = .identity
//                        self.view.layoutIfNeeded()
//                       }
//        )
//        UIView.animate(withDuration: 1.5,
//                       delay: 0.75,
//                       options: [.curveEaseInOut],
//                       animations: { [self] in
//                        loginButton.alpha = 1
//                        loginButton.transform = .identity
//                        self.view.layoutIfNeeded()
//                       }
//        )
        
    }
}
