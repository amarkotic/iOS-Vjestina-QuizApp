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
        
        //gradient backgroun
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 4.0, y: 1.0)
        view.layer.insertSublayer(gradientLayer, at: 0)

        
        //PopQuiz label
        quizNameLabel.text = "PopQuiz"
        quizNameLabel.font = UIFont(name: "Futura", size: 40)
        quizNameLabel.textAlignment = NSTextAlignment.center
        
        //main stackview
        stackView.distribution  = .equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 20.0
        stackView.axis = NSLayoutConstraint.Axis.vertical
        
        //emailtextfield
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = .always
        emailTextField.backgroundColor =  UIColor(white: 1, alpha: 0.5)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email")
        emailTextField.textColor = .white
        emailTextField.layer.cornerRadius = 20
        
        //pasword text field
        let paddingView2: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        passwordTextField.leftView = paddingView2
        passwordTextField.leftViewMode = .always
        passwordTextField.backgroundColor = UIColor(white: 1, alpha: 0.5)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password")
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.cornerRadius = 20
        
        //loginButton
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        loginButton.setTitleColor(.purple, for: .normal)
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.cornerRadius = 20
        
        //dodaj elemente u stackView
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        
    }
    
    private func defineLayoutForViews() {
        //PopQuiz label
        view.addSubview(quizNameLabel)
        quizNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(30)
            make.size.equalTo(CGSize(width: 200, height: 200))
            make.centerX.equalTo(view)
        }
        
        //main stackView
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(quizNameLabel.snp.bottom).offset(40)
        }
        
        //emailtextfield
        emailTextField.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 250, height: 40))
        }
        
        //passwordTextField
        passwordTextField.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 250, height: 40))
        }
        
        //loginbutton
        loginButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 250, height: 40))
        }
    }
    
}


