//
//  LoginViewController+Design.swift
//  QuizApp
//
//  Created by Antonio Markotic on 29.05.2021..
//

import UIKit
import SnapKit


extension LoginViewController{
    
    //DESIGN
    func buildViews() {

        styleViews()
        defineLayoutForViews()

    }

    
    private func styleViews() {
        
        //gradient background
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 4.0, y: 1.0)
        view.layer.insertSublayer(gradientLayer, at: 0)

        
        //PopQuiz label
        quizNameLabel.alpha = 0
        quizNameLabel.text = "PopQuiz"
        quizNameLabel.font = UIFont(name: "Futura", size: 40)
        quizNameLabel.textAlignment = NSTextAlignment.center
        
        //No Internet Label
        noInternetLabel.text = "No Internet Connection"
        noInternetLabel.font = UIFont(name: "Futura", size: 20)
        noInternetLabel.textAlignment = NSTextAlignment.center
        noInternetLabel.backgroundColor = .gray
        noInternetLabel.alpha = 0.5
        noInternetLabel.isHidden = true

        //emailtextfield
        emailTextField.alpha = 0
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = .always
        emailTextField.backgroundColor =  UIColor(white: 1, alpha: 0.5)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email")
        emailTextField.textColor = .white
        emailTextField.layer.cornerRadius = 20
        
        //pasword text field
        passwordTextField.alpha = 0
        let paddingView2: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        passwordTextField.leftView = paddingView2
        passwordTextField.leftViewMode = .always
        passwordTextField.backgroundColor = UIColor(white: 1, alpha: 0.5)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password")
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.cornerRadius = 20
        
        //loginButton
        loginButton.alpha = 0
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        loginButton.setTitleColor(.purple, for: .normal)
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.cornerRadius = 20
        
        
    }
    
    private func defineLayoutForViews() {
        //PopQuiz label
        view.addSubview(quizNameLabel)
        quizNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(50)
            make.centerX.equalTo(view)
        }
        quizNameLabel.transform = quizNameLabel.transform.scaledBy(x: 200, y: 200)
        
        
        //no internet
        view.addSubview(noInternetLabel)
        noInternetLabel.snp.makeConstraints { make in
            make.top.equalTo(quizNameLabel.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
        //emailtextfield
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(noInternetLabel.snp.bottom).offset(70)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 250, height: 40))
        }
        emailTextField.transform = emailTextField.transform.translatedBy(x: 0, y: 0)
        
        
        //passwordTextField
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 250, height: 40))
        }
        passwordTextField.transform = emailTextField.transform.translatedBy(x: 0, y: 0)
        
        
        //loginbutton
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 250, height: 40))
        }
        loginButton.transform = emailTextField.transform.translatedBy(x: 0, y: 0)
    }
    
}


