//
//  LeaderboardCell.swift
//  QuizApp
//
//  Created by Antonio Markotic on 16.05.2021..
//

import Foundation
import UIKit
class LeaderboardCell: UITableViewCell{
    
    var mainView = UIView()
    
    var nameScoreStack = UIStackView()
    var nameLabel = UILabel()
    var scoreLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        setContraints()
        loadElements()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //popunjavanje leaderboarda podatcima iz liste koja je popunjena podatcima s API-a
    func set(playerName: String, scoreL:String){
        nameLabel.text = playerName
        let score = scoreL
        let items = score.components(separatedBy: ".")
        scoreLabel.text = items[0]
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
