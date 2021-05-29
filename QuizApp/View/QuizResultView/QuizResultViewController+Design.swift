//
//  QuizResultViewController+Design.swift
//  QuizApp
//
//  Created by Antonio Markotic on 29.05.2021..
//

import SnapKit
import UIKit

extension QuizResultViewController{
    func buildViews(){
        loadElements()
        setConstraints()
    }
    
    
    
    func setConstraints(){
        
        //scorelabel
        self.view.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { (make) in
            make.width.equalTo(view.frame.width / 2)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-100)
        }
        
    
        //finishquizbutton
        self.view.addSubview(finishButton)
        finishButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: view.frame.width * 0.8, height: 70))
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-50)
        }
        
        //seeLeaderBoard
        self.view.addSubview(seeLeaderBoardButton)
        seeLeaderBoardButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: view.frame.width * 0.8, height: 70))
            make.centerX.equalTo(view)
            make.bottom.equalTo(finishButton.snp.top).offset(-20)
        }
      
    }
    
    
    func loadElements(){
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
