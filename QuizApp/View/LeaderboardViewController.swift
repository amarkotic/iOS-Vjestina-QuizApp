//
//  LeaderboardViewController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 16.05.2021..
//

import UIKit

class LeaderboardViewController: UIViewController {
    
    let leaderboardLabel: UILabel = UILabel()
    let exitButton = UIButton()
    var tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
    var list = [LeaderboardResult]()
    private let leaderboardPresenter = LeaderboardPresenter(networking: NetworkService())
    let defaults = UserDefaults()
    let loadingImage = UIImageView()
    private var router: AppRouter!
    convenience init(router: AppRouter) {
        self.init()
        self.router = router
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        leaderboardPresenter.setLeaderboardViewDelegate(leaderboardViewDelegate: self)
        leaderboardPresenter.fetchLeaderboard()
        tableView.isHidden = true
        setConstraints()
        loadElements()
        
        exitButton.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
    }
    
    func populateList(recievedList : [LeaderboardResult]){
        list = recievedList
        loadingImage.isHidden = true
        tableView.isHidden = false
        loadTableViewData()
            
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
    
    func loadElements(){
        view.backgroundColor = .purple
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
    
    @objc func exitButtonPressed(){
        router.dissmisLeaderBoard()
    }

}

extension LeaderboardViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}



extension LeaderboardViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return list.count
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height:50))
     
        let nameLabel = UILabel()
        nameLabel.text = "Player"
        let scoreLabel = UILabel()
        scoreLabel.text = "Points"
        scoreLabel.textAlignment = .right
        nameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        //namescoreStack
        let nameScoreStack = UIStackView(frame: CGRect(x: 25, y: 0, width: headerView.frame.width-50, height: headerView.frame.height))
        nameScoreStack.distribution  = UIStackView.Distribution.fillEqually
        nameScoreStack.alignment = UIStackView.Alignment.center
        nameScoreStack.spacing   = 3.0
        nameScoreStack.axis = NSLayoutConstraint.Axis.horizontal
   
        nameScoreStack.addArrangedSubview(nameLabel)
        nameScoreStack.addArrangedSubview(scoreLabel)
        
        headerView.addSubview(nameScoreStack)
        let separatorView = UIView(frame: CGRect(x: tableView.separatorInset.left, y: headerView.frame.height, width: tableView.frame.width - tableView.separatorInset.right - tableView.separatorInset.left, height: 1))
        separatorView.backgroundColor = .white
        headerView.addSubview(separatorView)

        return headerView
        
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell") as! LeaderboardCell
        cell.backgroundColor = .purple
        cell.set(playerName: list[indexPath.row].username, scoreL: list[indexPath.row].score)

        return cell
    }
}
