//
//  TableViewCell.swift
//  QuizApp
//
//  Created by Antonio Markotic on 21.04.2021..
//

import UIKit

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
        
        //add Subviews
        addSubview(mainView)
        addSubview(cellImageView)
        addSubview(titleAndDescriptionStack)
        addSubview(levelStackView)

        //configure views
        configureView()
        configureImageView()
        configureTitle()
        configureDescription()
        configuretitleAndDescriptionStack()
        configureLevelViews()
        configureLevelStackView()
        
        //set constraints
        setMainViewConstraints()
        settitleAndDescriptionStackConstraints()
        setImageConstraints()
        setLevelStackConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //logika spajanja podataka iz DataServicea u pojedini ViewCell
    func set(quiz: Quiz, color: UIColor){
        cellImageView.image = UIImage(named: "football.jpg")
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
    
    

    func configureView(){
        mainView.layer.cornerRadius = 15
        mainView.clipsToBounds = true
        mainView.backgroundColor = .white
        mainView.alpha = 0.50
    }

    func configureImageView(){
        cellImageView.layer.cornerRadius = 10
        cellImageView.clipsToBounds = true
    }
    
    func configureTitle(){
        cellTitle.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    func configureDescription(){
        cellDescription.numberOfLines = 0
        cellDescription.adjustsFontSizeToFitWidth = true
    }
    
    func configuretitleAndDescriptionStack(){
        titleAndDescriptionStack.distribution  = UIStackView.Distribution.fillProportionally
        titleAndDescriptionStack.alignment = UIStackView.Alignment.leading
        titleAndDescriptionStack.spacing   = 20.0
        titleAndDescriptionStack.axis = NSLayoutConstraint.Axis.vertical
        titleAndDescriptionStack.addArrangedSubview(cellTitle)
        titleAndDescriptionStack.addArrangedSubview(cellDescription)
    }
    
    func configureLevelViews(){
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
    }
    
    func configureLevelStackView(){
        levelStackView.distribution  = UIStackView.Distribution.fillEqually
        levelStackView.alignment = UIStackView.Alignment.center
        levelStackView.spacing   = 3.0
        levelStackView.axis = NSLayoutConstraint.Axis.horizontal
     
        levelStackView.addArrangedSubview(levelOneView)
        levelStackView.addArrangedSubview(levelTwoView)
        levelStackView.addArrangedSubview(levelThreeView)
    }
    
    
    
    
    
    
    
    func setMainViewConstraints(){
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
    

    func setImageConstraints(){
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12).isActive = true
        cellImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        cellImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cellImageView.contentMode = .scaleAspectFill
    }
    
    func settitleAndDescriptionStackConstraints(){
        titleAndDescriptionStack.topAnchor.constraint(equalTo: cellImageView.topAnchor, constant: 10).isActive = true
        titleAndDescriptionStack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -30).isActive = true
        titleAndDescriptionStack.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 20).isActive = true
        titleAndDescriptionStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,constant: -30).isActive = true
        titleAndDescriptionStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setLevelStackConstraints(){
        levelStackView.translatesAutoresizingMaskIntoConstraints = false
        levelStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20).isActive = true
        levelStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20).isActive  = true
        levelStackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        levelStackView.widthAnchor.constraint(equalToConstant: 60).isActive  = true
    }
    
}
