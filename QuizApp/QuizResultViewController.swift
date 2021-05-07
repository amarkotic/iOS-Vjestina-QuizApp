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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .purple
        scoreLabel.text = "\(numOfCorrectAnswers)/\(totalNumOfQuestions)"
        setConstraints()
        finishButton.addTarget(self, action: #selector(finishQuiz), for: .touchUpInside)
    }
   
    
    
    
    func set (numOfCorrect:Int, numOfQuestions:Int){
        numOfCorrectAnswers = numOfCorrect
        totalNumOfQuestions = numOfQuestions
    }
    
    func setConstraints(){
        self.view.addSubview(scoreLabel)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        scoreLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont(name: "Futura", size: 70)
        
        self.view.addSubview(finishButton)
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        finishButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        finishButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        finishButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        finishButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        finishButton.layer.cornerRadius = 35
        finishButton.backgroundColor = .white
        finishButton.setTitle("Finish Quiz", for: .normal)
        finishButton.setTitleColor(.purple, for: .normal)
        
    }
    @objc func finishQuiz(){
        self.dismiss(animated: false, completion: nil)
        navigationController?.popToRootViewController(animated: true)

    }
    

}
