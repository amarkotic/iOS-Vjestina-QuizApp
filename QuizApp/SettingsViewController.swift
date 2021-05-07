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

    override func viewDidLoad() {
        super.viewDidLoad()
        logoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        self.view.backgroundColor = .purple
        fixedUsernameLabel.text = "USERNAME"
        usernameLabel.text = "SportJunkie1234"
        setConstraints()
        
        
    }
    
    func setConstraints(){
    
        self.view.addSubview(usernameStack)
        usernameStack.translatesAutoresizingMaskIntoConstraints = false
        usernameStack.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        usernameStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        usernameStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        
        usernameStack.distribution  = UIStackView.Distribution.fillProportionally
        usernameStack.alignment = UIStackView.Alignment.leading
        usernameStack.spacing   = 15.0
        usernameStack.axis = NSLayoutConstraint.Axis.vertical
        
        fixedUsernameLabel.font = UIFont(name: "Futura", size: 20)
        fixedUsernameLabel.textColor = .white
        
        usernameLabel.font = UIFont(name: "Futura", size: 30)
        usernameLabel.textColor = .white
        
        usernameStack.addArrangedSubview(fixedUsernameLabel)
        usernameStack.addArrangedSubview(usernameLabel)
        
        
        
        
        self.view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        logoutButton.layer.cornerRadius = 35
        logoutButton.backgroundColor = .white
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.setTitleColor(.red, for: .normal)
    
    }
    

    @objc func logOut(){
        self.view.window!.rootViewController?.presentedViewController?.dismiss(animated:false, completion: nil)
    }

}
