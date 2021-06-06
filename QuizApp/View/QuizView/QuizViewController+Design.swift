//
//  QuizViewController+Design.swift
//  QuizApp
//
//  Created by Antonio Markotic on 05.06.2021..
//

import Foundation
import UIKit
import SnapKit

extension QuizViewController{
    
    func buildViews(){
        setConstraints()
        loadElements()
    }
    
    
    func setConstraints(){
        //timer
        self.view.addSubview(timerLabel)
        timerLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: view.frame.width / 3, height: 20))
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
        }
        
        
        //questionNum
        self.view.addSubview(questionNum)
        questionNum.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: view.frame.width * 0.2, height: 20))
            make.leading.equalTo(view).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        
        //progressStackView
        self.view.addSubview(progressStackView)
        progressStackView.snp.makeConstraints { (make) in
            make.top.equalTo(questionNum.snp.bottom).offset(10)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(10)
        }
        
        //pageController
        childPageController.view.frame = CGRect(x: 0, y: 150, width: view.frame.width, height: view.frame.height-150)
    }
    
    
    func loadElements(){

        self.view.backgroundColor = .purple
        
        //timerlabel
        timerLabel.font = UIFont(name: "Futura", size: 20)
        timerLabel.textAlignment = .center
        
        //initial question num
        questionNum.text = "1/\(numberOfQuestions)"
        
        //dodavanje pageController-a i uklanjanje mogućnosti rucnog swipe-anja njegovih page-ova
        addChild(childPageController)
        view.addSubview(childPageController.view)
        for view in self.childPageController.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
}
