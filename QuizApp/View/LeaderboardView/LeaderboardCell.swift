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
        //UI
        buildViews()
        
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
    
}
