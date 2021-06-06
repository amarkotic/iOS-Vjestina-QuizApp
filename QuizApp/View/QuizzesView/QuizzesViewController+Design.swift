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
    func buildViews() {
        
        defineLayoutForViews()
        styleViews()
        }

    func styleViews(){
        view.backgroundColor = .purple
        self.navigationController?.navigationBar.isHidden = true
        
        //quizName
        quizNameLabel.text = "PopQuiz"
        quizNameLabel.font = UIFont(name: "Futura", size: 30)
        quizNameLabel.textAlignment = NSTextAlignment.center
        
        
        //fun stack
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
        

        //tableView
        tableView.backgroundColor = .purple
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "QuizzCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.rowHeight = 180
        tableView.bounces = true
        
    }
    func defineLayoutForViews(){
        //quizNameLabel
        view.addSubview(quizNameLabel)
        quizNameLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 200, height: 100))
            make.top.equalTo(view).offset(20)
            make.centerX.equalTo(view)
        }
        
        //fun fact stack ispod kojeg dolaze kvizovi
        view.addSubview(funFactStack)
        funFactStack.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(quizNameLabel.snp.bottom).offset(15)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        
        view.addSubview(bulbImageView)
        bulbImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        
        
        tableView = UITableView(frame: CGRect(x: 0, y: 230, width: view.bounds.width, height: view.bounds.height-230), style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

}
