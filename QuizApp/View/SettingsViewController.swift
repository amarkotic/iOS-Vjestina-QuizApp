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
        setConstraints()
        loadElements()
        
      
       
        
        //funkcionalnost
        logoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    }
    
    func setConstraints(){
        
        //usernameStack
        self.view.addSubview(usernameStack)
        usernameStack.snp.makeConstraints { (make) in
            make.width.equalTo(view.frame.width * 0.9)
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(70)
        }

        //logoutButton
        self.view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: view.frame.width * 0.8, height: 70))
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
    }
    
    
    func loadElements(){
        self.view.backgroundColor = .purple
        fixedUsernameLabel.text = "USERNAME"
        usernameLabel.text = "SportJunkie1234"
        
        //usernameStack
        usernameStack.distribution  = UIStackView.Distribution.fillProportionally
        usernameStack.alignment = UIStackView.Alignment.leading
        usernameStack.spacing   = 15.0
        usernameStack.axis = NSLayoutConstraint.Axis.vertical
        
        fixedUsernameLabel.font = UIFont(name: "Futura", size: 20)
        fixedUsernameLabel.textColor = .white
        
        usernameLabel.font = UIFont(name: "Futura", size: 30)
        usernameLabel.textColor = .white
        
        //dodaj 2 elementa u usernameStack
        usernameStack.addArrangedSubview(fixedUsernameLabel)
        usernameStack.addArrangedSubview(usernameLabel)
        
        
        //logoutbutton
        logoutButton.layer.cornerRadius = 35
        logoutButton.backgroundColor = .white
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.setTitleColor(.red, for: .normal)
        
    }

    @objc func logOut(){
        router.showLogin()
    }

}
