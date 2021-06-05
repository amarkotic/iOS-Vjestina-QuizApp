//
//  QuizzesViewController+Design.swift
//  QuizApp
//
//  Created by Antonio Markotic on 29.05.2021..
//

import UIKit
import SnapKit

extension QuizzesViewController{
    
    //DESIGN
    func buildViewsBeforeFetch() {
        styleViewsBeforeFetch()
        defineLayoutForViewsBeforeFetch()
    }

    func buildViewsAfterFetch(){
        defineLayoutForViewsAfterFetch()
        styleViewsAfterFetch()
       
    }
    func styleViewsBeforeFetch(){
        view.backgroundColor = .purple
        self.navigationController?.navigationBar.isHidden = true
        
        //quizName
        quizNameLabel.text = "PopQuiz"
        quizNameLabel.font = UIFont(name: "Futura", size: 30)
        quizNameLabel.textAlignment = NSTextAlignment.center
        
        //quizButton
        getQuizzButton.setTitle("Get Quizz", for: .normal)
        getQuizzButton.backgroundColor = UIColor(white: 1, alpha: 1)
        getQuizzButton.setTitleColor(.purple, for: .normal)
        getQuizzButton.layer.cornerRadius = 20
        
        
        //error stack
        errorStack.distribution  = UIStackView.Distribution.fillProportionally
        errorStack.alignment = UIStackView.Alignment.center
        errorStack.spacing   = 0.0
        errorStack.axis = NSLayoutConstraint.Axis.vertical
        
        //četiri elementa errorstackview-a
        errorImageView.image = UIImage(named: "error")
        errorImageView.contentMode = .scaleAspectFit
        errorTitle.text = "Error\n"
        errorTitle.font = UIFont.boldSystemFont(ofSize: 27)
        errorDescription1.text = "Data can't be reached."
        errorDescription2.text = "Please try again"
        
        //dodaj elemente u stackView
        errorStack.addArrangedSubview(errorImageView)
        errorStack.addArrangedSubview(errorTitle)
        errorStack.addArrangedSubview(errorDescription1)
        errorStack.addArrangedSubview(errorDescription2)
    }
    
    
    func defineLayoutForViewsBeforeFetch(){
        //popQuizLabel
        view.addSubview(quizNameLabel)
        quizNameLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 200, height: 100))
            make.top.equalTo(view).offset(20)
            make.centerX.equalTo(view)
        }
        
        //getquizbutton
        view.addSubview(getQuizzButton)
        getQuizzButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: view.frame.width * 0.8, height: 40))
            make.top.equalTo(quizNameLabel.snp.bottom).offset(0)
            make.centerX.equalTo(view)
        }
        
        //errorstack
        view.addSubview(errorStack)
        errorStack.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: view.frame.width * 0.8, height: view.frame.height * 0.35))
            make.centerX.centerY.equalTo(view)
            
        }
    }
    
    
    
    func styleViewsAfterFetch(){
        //funfact stack
        funFactStack.distribution  = UIStackView.Distribution.equalSpacing
        funFactStack.alignment = UIStackView.Alignment.leading
        funFactStack.spacing   = 15.0
        funFactStack.axis = NSLayoutConstraint.Axis.vertical
        
        //bulbStack koji je dio funFactstack-a
        bulbStackView.alignment = UIStackView.Alignment.leading
        bulbStackView.spacing   = 5
        bulbStackView.axis = NSLayoutConstraint.Axis.horizontal
        
        //elementi bulbStack-a
        bulbImage = UIImage(named: "Bulb")!
        bulbImageView.image = bulbImage
        funFactLabel.text = "Fun fact"
        funFactLabel.font = UIFont(name: "Futura", size: 25)
        
        
        //dodaj elemente u bulbStackView
        bulbStackView.addArrangedSubview(bulbImageView)
        bulbStackView.addArrangedSubview(funFactLabel)
        
        //drugi element funfactStacka
        funFactDescription.numberOfLines = 0
        
        //dodaj elemente u glavni stack; funFactStack
        funFactStack.addArrangedSubview(bulbStackView)
        funFactStack.addArrangedSubview(funFactDescription)
        
        funFactStack.isHidden = true
        
        
        
        tableView.backgroundColor = .purple
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "QuizzCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.rowHeight = 180
        tableView.bounces = true
        
        tableView.isHidden = true
        
        
    }
    func defineLayoutForViewsAfterFetch(){
        //fun fact stack ispod kojeg dolaze kvizovi
        view.addSubview(funFactStack)
        funFactStack.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(getQuizzButton.snp.bottom).offset(30)
        }
        
        view.addSubview(bulbImageView)
        bulbImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView = UITableView(frame: CGRect(x: 0, y: 280, width: view.bounds.width, height: view.bounds.height-280))
    }
    
}
