//
//  TableViewCell.swift
//  QuizApp
//
//  Created by Antonio Markotic on 21.04.2021..
//

import UIKit
import SnapKit

class TableViewCell:UITableViewCell{
    
    var mainView = UIView()
    var cellImageView =  UIImageView()
    
    //stack
    var titleAndDescriptionStack = UIStackView()
    var cellTitle = UILabel()
    var cellDescription = UILabel()
    
    //level variables
    var quizLevel:Int = 0
    var levelStackView = UIStackView()
    var levelOneView = UIView()
    var levelTwoView = UIView()
    var levelThreeView = UIView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       buildViews()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //popunjavanje QuizView-ova podatcima iz matrixa koji je popunjen podatcima s API-a
    func set(quiz: Quiz, color: UIColor){

        let url = URL(string: quiz.imageUrl)
        DispatchQueue.global().async {
        if let data = try? Data(contentsOf: url!){
            DispatchQueue.main.async {
                self.cellImageView.image = UIImage(data: data)
            }
        }
        }
        cellTitle.text = quiz.title
        cellDescription.text = quiz.description
        quizLevel = quiz.level
        switch quizLevel{
    case 1:
        levelOneView.backgroundColor = color
        levelTwoView.backgroundColor = .white
        levelThreeView.backgroundColor = .white
    case 2:
        levelOneView.backgroundColor = color
        levelTwoView.backgroundColor = color
        levelThreeView.backgroundColor = .white
    case 3:
        levelOneView.backgroundColor = color
        levelTwoView.backgroundColor = color
        levelThreeView.backgroundColor = color
    default:
        levelOneView.backgroundColor = .white
        levelTwoView.backgroundColor = .white
        levelThreeView.backgroundColor = .white
        }
    }
    
    
  
    
}
