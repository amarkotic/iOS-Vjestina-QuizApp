//
//  TableViewCell+Design.swift
//  QuizApp
//
//  Created by Antonio Markotic on 29.05.2021..
//

import UIKit
import SnapKit

extension TableViewCell{
    
    func buildViews(){
        loadElements()
        setContraints()
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
