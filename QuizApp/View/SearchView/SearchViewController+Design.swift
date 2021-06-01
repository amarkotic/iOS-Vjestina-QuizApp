//
//  SearchViewController+Design.swift
//  QuizApp
//
//  Created by Antonio Markotic on 01.06.2021..
//

import Foundation
import UIKit
import SnapKit


extension SearchViewController{
    func buildViews(){
        setConstraints()
        loadElements()
    }
    
    
    func setConstraints(){
        //search button
        searchButton.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width * 0.2)
            make.height.equalTo(40)
        }
        
        inputTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        //search stack
        view.addSubview(searchStack)
        searchStack.snp.makeConstraints { make in
            make.top.equalTo(view).offset(100)
            make.centerX.equalTo(view)
            make.width.equalTo(view.frame.width*0.90)
           
        }
       
        
        //table view
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView = UITableView(frame: CGRect(x: 0, y: 180, width: view.bounds.width, height: view.bounds.height-180))
    }
    
    func loadElements(){
        view.backgroundColor = .purple
        
        
        //inputtextfield
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        inputTextField.leftView = paddingView
        inputTextField.leftViewMode = .always
        inputTextField.backgroundColor =  UIColor(white: 1, alpha: 0.5)
        inputTextField.attributedPlaceholder = NSAttributedString(string: "Type here")
        inputTextField.textColor = .white
        inputTextField.layer.cornerRadius = 20
        
        //button
        searchButton.setTitle("Search", for: .normal)
        searchButton.tintColor = .white
        searchButton.titleLabel?.font = UIFont(name: "Futura", size: 15)
       
        
        //searchStack
        searchStack.distribution  = UIStackView.Distribution.fillProportionally
        searchStack.alignment = UIStackView.Alignment.trailing
        searchStack.spacing   = 15.0
        searchStack.axis = NSLayoutConstraint.Axis.horizontal
        searchStack.addArrangedSubview(inputTextField)
        searchStack.addArrangedSubview(searchButton)
        
        
        //tableview
        //tableView
        tableView.backgroundColor = .purple
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "QuizzCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.rowHeight = 180
        tableView.bounces = true
    }
}
