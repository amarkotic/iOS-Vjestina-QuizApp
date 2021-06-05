//
//  LeaderboardCell+Design.swift
//  QuizApp
//
//  Created by Antonio Markotic on 29.05.2021..
//

import UIKit
import SnapKit

extension LeaderboardCell {
    func buildViews(){
        loadElements()
        setContraints()
    }
    
    
    
    func setContraints(){
        
        //main view
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-5)
        }
        
       addSubview(nameScoreStack)
        nameScoreStack.snp.makeConstraints { (make) in
            make.leading.top.bottom.trailing.equalTo(mainView)
        }
       
        
        
    }
    
    func loadElements(){
        //nameScoreStack
        nameScoreStack.distribution  = UIStackView.Distribution.fillEqually
        nameScoreStack.alignment = UIStackView.Alignment.center
        nameScoreStack.spacing   = 3.0
        nameScoreStack.axis = NSLayoutConstraint.Axis.horizontal
        
  

        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 27)
        scoreLabel.textAlignment = .right
        nameLabel.text = "Yo"
        scoreLabel.text = "22"
        nameScoreStack.addArrangedSubview(nameLabel)
        nameScoreStack.addArrangedSubview(scoreLabel)
        
    }
}
