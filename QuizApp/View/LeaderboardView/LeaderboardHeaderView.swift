//
//  LeaderboardHeaderView.swift
//  QuizApp
//
//  Created by Antonio Markotic on 29.05.2021..
//

import Foundation
import UIKit

class LeaderboardHeaderView : UITableViewHeaderFooterView{
    
    let nameLabel = UILabel()
    let scoreLabel = UILabel()
    let nameScoreStack = UIStackView()
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        buildViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    
    func buildViews(){
        nameLabel.text = "Player"
        scoreLabel.text = "Points"
        scoreLabel.textAlignment = .right
        
   
       
        nameScoreStack.distribution  = UIStackView.Distribution.fillEqually
        nameScoreStack.alignment = UIStackView.Alignment.center
        nameScoreStack.spacing   = 3.0
        nameScoreStack.axis = NSLayoutConstraint.Axis.horizontal

        nameScoreStack.addArrangedSubview(nameLabel)
        nameScoreStack.addArrangedSubview(scoreLabel)
        
        self.addSubview(nameScoreStack)
    
        
        //constraints
        nameScoreStack.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
    }

}
