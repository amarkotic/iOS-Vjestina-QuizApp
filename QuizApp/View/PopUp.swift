//
//  PopUp.swift
//  QuizApp
//
//  Created by Antonio Markotic on 22.04.2021..
//

import UIKit

class PopUp: UIView {
    let question = UILabel()
    let mainView = UIView()
    let answerStackView = UIStackView()
    let answerOne = UIButton()
    let answerTwo = UIButton()
    let answerThree = UIButton()
    let answerFour = UIButton()
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        self.addSubview(mainView)
        mainView.backgroundColor = .purple
        configureMainView()
        setConstraintsMainView()
        
        
        
        self.backgroundColor = .gray
        self.alpha = 1
        self.frame = UIScreen.main.bounds
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

        

    
    func configureMainView(){
        mainView.layer.cornerRadius = 15
        mainView.clipsToBounds = true
        mainView.backgroundColor = .purple
        mainView.addSubview(question)
        mainView.addSubview(answerStackView)
        
        setQuestionConstraints()
        setStackConstraints()
    }
    func setConstraintsMainView(){
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mainView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        mainView.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.6).isActive = true
        mainView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.8).isActive = true
    }
    
    
    
    
    
    func setQuestionConstraints(){
        question.translatesAutoresizingMaskIntoConstraints = false
        question.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,constant: 25).isActive = true
        question.topAnchor.constraint(equalTo: mainView.topAnchor,constant: 30).isActive = true
        question.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,constant: -40).isActive = true
        question.numberOfLines = 0
    
        question.font = UIFont.boldSystemFont(ofSize: 25)
        question.text = "Who was the most famous Croatian basketball player in the NBA? "
        answerOne.titleLabel?.text = "Dario Šarić"
        answerTwo.titleLabel?.text = "Drazen Petrovic"
        answerThree.titleLabel?.text = "Bojan Bogadnović"
        answerFour.titleLabel?.text = "Dino Rađa"
    }
    
    
    
    
    func setStackConstraints(){
        answerStackView.distribution  = UIStackView.Distribution.fillEqually
        answerStackView.alignment = UIStackView.Alignment.center
        answerStackView.spacing   = 10.0
        answerStackView.axis = NSLayoutConstraint.Axis.vertical
        
        answerStackView.translatesAutoresizingMaskIntoConstraints = false
        answerStackView.topAnchor.constraint(equalTo: question.bottomAnchor, constant: 20).isActive = true
        answerStackView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        answerStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor,constant: -40).isActive = true
        answerStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,constant: -30).isActive = true
        answerStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,constant: 30).isActive = true
        
       
        answerOne.layer.cornerRadius = 15
        answerOne.clipsToBounds = true
        answerOne.backgroundColor = .white
        answerOne.alpha = 0.50
        
        answerTwo.layer.cornerRadius = 15
        answerTwo.clipsToBounds = true
        answerTwo.backgroundColor = .white
        answerTwo.alpha = 0.50
        
        answerThree.layer.cornerRadius = 15
        answerThree.clipsToBounds = true
        answerThree.backgroundColor = .white
        answerThree.alpha = 0.50
        
        answerFour.layer.cornerRadius = 15
        answerFour.clipsToBounds = true
        answerFour.backgroundColor = .white
        answerFour.alpha = 0.50
        answerStackView.addArrangedSubview(answerOne)
        answerStackView.addArrangedSubview(answerTwo)
        answerStackView.addArrangedSubview(answerThree)
        answerStackView.addArrangedSubview(answerFour)
    }
    
    
}
