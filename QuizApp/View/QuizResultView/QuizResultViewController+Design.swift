//
//  QuizResultViewController+Design.swift
//  QuizApp
//
//  Created by Antonio Markotic on 29.05.2021..
//

import SnapKit
import UIKit
import SAConfettiView

extension QuizResultViewController{
    func buildViews(){
        loadElements()
        setConstraints()
    }
    
    
    
    func setConstraints(){
        
        //scorelabel
        self.view.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(view.frame.width/2)
        }
        scoreLabel.transform = scoreLabel.transform.scaledBy(x: 200, y: 200)
        
 
        
        //finishquizbutton
        self.view.addSubview(finishButton)
        finishButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: view.frame.width * 0.8, height: 70))
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-50)
        }
        finishButton.transform = finishButton.transform.translatedBy(x: 0, y: 0)
        
        //seeLeaderBoard
        self.view.addSubview(seeLeaderBoardButton)
        seeLeaderBoardButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: view.frame.width * 0.8, height: 70))
            make.centerX.equalTo(view)
            make.bottom.equalTo(finishButton.snp.top).offset(-20)
        }
        seeLeaderBoardButton.transform = seeLeaderBoardButton.transform.translatedBy(x: 0, y: 0)
      
    }
    
    
    func loadElements(){
        //confetti view
        let confettiView = SAConfettiView(frame: self.view.bounds)
        confettiView.type = .Diamond
        view.addSubview(confettiView)
        confettiView.startConfetti()
        
        self.navigationController?.navigationBar.isHidden = false
        scoreLabel.text = "\(numOfCorrectAnswers)/\(totalNumOfQuestions)"
        self.view.backgroundColor = .purple
        
        //scorelabel
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont(name: "Futura", size: 70)
        
        
        //seeleaderboard
        seeLeaderBoardButton.layer.cornerRadius = 35
        seeLeaderBoardButton.backgroundColor = .white
        seeLeaderBoardButton.setTitle("See leaderboard", for: .normal)
        seeLeaderBoardButton.setTitleColor(.purple, for: .normal)
        
        //finishbutton
        finishButton.layer.cornerRadius = 35
        finishButton.backgroundColor = .white
        finishButton.setTitle("Finish Quiz", for: .normal)
        finishButton.setTitleColor(.purple, for: .normal)
    }
}
