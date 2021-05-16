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
        
        
        setContraints()
        loadElements()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //popunjavanje QuizView-ova podatcima iz matrixa koji je popunjen podatcima s API-a
    func set(quiz: Quiz, color: UIColor){
        let url = URL(string: quiz.imageUrl)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.cellImageView.image = UIImage(data: data!)
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
    
    
    func setContraints(){
        
        //main view
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-5)
        }

        //cellImageView
        addSubview(cellImageView)
        cellImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.centerY.equalToSuperview()
            make.leading.equalTo(mainView.snp.leading).offset(12)
        }
        
        
        //titleandDescriptionStack
        addSubview(titleAndDescriptionStack)
        titleAndDescriptionStack.snp.makeConstraints { (make) in
            make.leading.equalTo(cellImageView.snp.trailing).offset(20)
            make.top.equalTo(cellImageView.snp.top).offset(10)
            make.trailing.equalTo(mainView.snp.trailing).offset(-30)
            make.bottom.equalTo(mainView.snp.bottom).offset(-30)
        }

        //levelStackView
        addSubview(levelStackView)
        levelStackView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 60, height: 20))
            make.top.equalTo(mainView.snp.top).offset(20)
            make.trailing.equalTo(mainView.snp.trailing).offset(-20)
        }

        
        
    }
    
    func loadElements(){
        //mainView
        mainView.layer.cornerRadius = 15
        mainView.clipsToBounds = true
        mainView.backgroundColor = .white
        mainView.alpha = 0.50
        
        //imageView
        cellImageView.layer.cornerRadius = 10
        cellImageView.clipsToBounds = true
        cellImageView.contentMode = .scaleAspectFill
        
        //title
        cellTitle.font = UIFont.boldSystemFont(ofSize: 17)
        
        //description
        cellDescription.numberOfLines = 0
        cellDescription.adjustsFontSizeToFitWidth = true
        
        //descriptionStack
        titleAndDescriptionStack.distribution  = UIStackView.Distribution.fillProportionally
        titleAndDescriptionStack.alignment = UIStackView.Alignment.leading
        titleAndDescriptionStack.spacing   = 20.0
        titleAndDescriptionStack.axis = NSLayoutConstraint.Axis.vertical
        //dodaj title i desription u stack
        titleAndDescriptionStack.addArrangedSubview(cellTitle)
        titleAndDescriptionStack.addArrangedSubview(cellDescription)
        
        //levelViews
        levelOneView.layer.cornerRadius = 17
        levelTwoView.layer.cornerRadius = 17
        levelThreeView.layer.cornerRadius = 17
        
        levelOneView.clipsToBounds = true
        levelTwoView.clipsToBounds = true
        levelThreeView.clipsToBounds = true
   
        levelOneView.heightAnchor.constraint(equalToConstant: 17).isActive = true
        levelTwoView.heightAnchor.constraint(equalToConstant: 17).isActive = true
        levelThreeView.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        levelOneView.alpha = 0.7
        levelTwoView.alpha = 0.7
        levelThreeView.alpha = 0.7
        
        //levelstackView
        levelStackView.distribution  = UIStackView.Distribution.fillEqually
        levelStackView.alignment = UIStackView.Alignment.center
        levelStackView.spacing   = 3.0
        levelStackView.axis = NSLayoutConstraint.Axis.horizontal
        //dodaj levelViewove u levelstack
        levelStackView.addArrangedSubview(levelOneView)
        levelStackView.addArrangedSubview(levelTwoView)
        levelStackView.addArrangedSubview(levelThreeView)
    }
    
}
