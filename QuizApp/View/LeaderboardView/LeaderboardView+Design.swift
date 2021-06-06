//
//  LeaderboardView+Design.swift
//  QuizApp
//
//  Created by Antonio Markotic on 29.05.2021..
//

import UIKit
import SnapKit


extension LeaderboardViewController{
    
    //DESIGN
    func buildViews(){
        loadElements()
        setConstraints()
    }
    func buildViewsAfterFetch(){
        loadingImage.isHidden = true
        tableView.isHidden = false
        
        loadTableViewData()
    }
    
    
    func loadElements(){
        
        
        view.backgroundColor = .purple
        tableView.isHidden = true
        tableView.backgroundColor = .purple
       
        
        //leaderboardLabel
        leaderboardLabel.text = "LeaderBoard"
        leaderboardLabel.font = UIFont(name: "Futura", size: 25)
        leaderboardLabel.textAlignment = NSTextAlignment.center
    
        //exitbutton
        exitButton.setImage(UIImage(named: "x-sign.jpg"), for: .normal)
        
        let loadingGif = UIImage(named: "loading")
        loadingImage.image = loadingGif
        
     
    }
    
    func setConstraints(){
        view.addSubview(leaderboardLabel)
        leaderboardLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(50)
            make.size.equalTo(CGSize(width: 350, height: 50))
            make.centerX.equalTo(view)
        }
        
        view.addSubview(exitButton)
        exitButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(leaderboardLabel.snp.bottom).offset(-10)
            make.trailing.equalTo(view).offset(-20)
            make.size.equalTo(CGSize(width: 40, height: 30))
        }
        view.addSubview(loadingImage)
        loadingImage.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(leaderboardLabel.snp.bottom).offset(30)
            make.width.equalTo(view)
            make.height.equalTo(view.frame.height - 30 - leaderboardLabel.frame.height)
        }

    }
    
    
    func loadTableViewData(){
      
        //tableview
        tableView.register(LeaderboardCell.self, forCellReuseIdentifier: "LeaderboardCell")
  
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = view.frame.height / 10
        tableView.bounces = true
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.separatorColor = .white
        tableView.allowsSelection = false
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    }
  
}
