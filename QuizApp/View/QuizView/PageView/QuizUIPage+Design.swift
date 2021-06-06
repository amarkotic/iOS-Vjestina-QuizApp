//
//  QuizUIPage+Design.swift
//  QuizApp
//
//  Created by Antonio Markotic on 05.06.2021..
//

import Foundation
import UIKit
import SnapKit

extension QuizUIPage{
    
    
    func createViews(){
        createElements()
        setConstraints()
    }
    
    
    func setConstraints(){
        //question
        self.view.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalTo(view).offset(40)
        }
        
        //answerStackView
        self.view.addSubview(answerStackView)
        answerStackView.snp.makeConstraints { (make) in
            make.height.equalTo(view.frame.height * 0.4)
            make.centerX.equalTo(view)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
            make.top.equalTo(questionLabel.snp.bottom).offset(40)
        }
    }
    
    func createElements(){
        //questionLabel
        questionLabel.text = question?.question
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont(name: "Futura", size: 25)
        questionLabel.textAlignment = .center
        
        //answerStackView
        answerStackView.distribution  = UIStackView.Distribution.fillEqually
        answerStackView.alignment = UIStackView.Alignment.center
        answerStackView.spacing   = 20.0
        answerStackView.axis = NSLayoutConstraint.Axis.vertical
        
        //answers
        answerOne.layer.cornerRadius = 40
        answerOne.clipsToBounds = true
        answerOne.backgroundColor = .white
        answerOne.backgroundColor? = UIColor(white: 1, alpha: 0.5)
        answerOne.setTitleColor(.white, for: .normal)
        answerOne.setTitle(question?.answers[0], for: .normal)
        
        answerTwo.layer.cornerRadius = 40
        answerTwo.clipsToBounds = true
        answerTwo.backgroundColor = .white
        answerTwo.backgroundColor? = UIColor(white: 1, alpha: 0.5)
        answerTwo.setTitleColor(.white, for: .normal)
        answerTwo.setTitle(question?.answers[1], for: .normal)
        
        answerThree.layer.cornerRadius = 40
        answerThree.clipsToBounds = true
        answerThree.backgroundColor = .white
        answerThree.backgroundColor? = UIColor(white: 1, alpha: 0.5)
        answerThree.setTitleColor(.white, for: .normal)
        answerThree.setTitle(question?.answers[2], for: .normal)
        
        answerFour.layer.cornerRadius = 40
        answerFour.clipsToBounds = true
        answerFour.backgroundColor = .white
        answerFour.backgroundColor? = UIColor(white: 1, alpha: 0.5)
        answerFour.setTitleColor(.white, for: .normal)
        answerFour.setTitle(question?.answers[3], for: .normal)
        
        //dodaj odgovore u answerStackView i postavi im širinu jer se u suprotnom neće prikazati
        answerStackView.addArrangedSubview(answerOne)
        answerStackView.addArrangedSubview(answerTwo)
        answerStackView.addArrangedSubview(answerThree)
        answerStackView.addArrangedSubview(answerFour)
        
        answerOne.widthAnchor.constraint(equalTo: answerStackView.widthAnchor, multiplier: 0.85).isActive = true
        answerTwo.widthAnchor.constraint(equalTo: answerStackView.widthAnchor, multiplier: 0.85).isActive = true
        answerThree.widthAnchor.constraint(equalTo: answerStackView.widthAnchor, multiplier: 0.85).isActive = true
        answerFour.widthAnchor.constraint(equalTo: answerStackView.widthAnchor, multiplier: 0.85).isActive = true
    }
}

