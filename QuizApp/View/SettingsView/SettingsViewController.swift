//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 07.05.2021..
//

import UIKit

class SettingsViewController: UIViewController {

    let usernameStack = UIStackView()
    let fixedUsernameLabel = UILabel()
    let usernameLabel = UILabel()
    let logoutButton = UIButton()
    
    
    private var router: AppRouter!
    convenience init(router: AppRouter) {
        self.init()
        self.router = router
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UI
        buildViews()
        
        //funkcionalnost
        logoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    }
    
    
    @objc func logOut(){
        router.showLogin()
    }

}
