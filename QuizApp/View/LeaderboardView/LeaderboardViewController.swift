//
//  LeaderboardViewController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 16.05.2021..
//

import UIKit


class LeaderboardViewController: UIViewController, LeaderboardProtocol {
    
    let leaderboardLabel: UILabel = UILabel()
    let exitButton = UIButton()
    var tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
    var list = [LeaderboardResult]()
    let defaults = UserDefaults()
    let loadingImage = UIImageView()
    
    private let leaderboardPresenter = LeaderboardPresenter(networking: NetworkService())
    

    
    
    private var router: AppRouter!
    convenience init(router: AppRouter) {
        self.init()
        self.router = router
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        leaderboardPresenter.fetchLeaderboard()
        leaderboardPresenter.setLeaderboardViewDelegate(leaderboardViewDelegate: self)
        
        tableView.register(LeaderboardHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        //UI
        buildViews()
        
        //funkcionalnost
        exitButton.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2,
                       delay: 0,
                       options: .curveLinear,
                       animations:{
                        self.loadingImage.transform = self.loadingImage.transform.rotated(by: 3)
                       }
                       )
    }
    func populateList(recievedList : [LeaderboardResult]){
        list = recievedList
        buildViewsAfterFetch()
    }

    
    @objc func exitButtonPressed(){
        router.dissmisLeaderBoard()
    }
}






//Table view delegate methods
extension LeaderboardViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}





//Table view Data Source methods
extension LeaderboardViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! LeaderboardHeaderView
        return headerCell
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
