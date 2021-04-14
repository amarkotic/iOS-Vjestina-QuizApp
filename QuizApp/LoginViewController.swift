//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 14.04.2021..
//

import UIKit

class LoginViewController: UIViewController {

    let quizNameLabel: UILabel = UILabel()
    
    let emailTextField: UITextField = UITextField()
    
    let passwordTextField: UITextField = UITextField()
    
    let loginButton : UIButton = UIButton()
    
    let stackView : UIStackView = UIStackView()
    
    let dService = DataService()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //visual
        view.backgroundColor = .purple
        view.addSubview(quizNameLabel)
        view.addSubview(stackView)
        loadElements()
        
        
        //skrivanje tipkovnice i odznačivanje textfieldova
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(uiViewPressed))
        view.addGestureRecognizer(tap)
         
        //funkcionalnost
        loginButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        emailTextField.addTarget(self, action: #selector(didTapEmailTextField), for: .editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(didTapPasswordTextField), for: .editingDidBegin)
    }
    
    private func loadElements(){
        
        //label
        quizNameLabel.translatesAutoresizingMaskIntoConstraints = false
        quizNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        quizNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant :30 ).isActive = true
        quizNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        quizNameLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        quizNameLabel.text = "PopQuiz"
        quizNameLabel.font = UIFont(name: "Futura", size: 40)
        quizNameLabel.textAlignment = NSTextAlignment.center
        

        
        //stackview za textfieldove i loginButton
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 20.0
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.topAnchor.constraint(equalTo: quizNameLabel.bottomAnchor, constant: 70).isActive = true
       
        
        //emailtextfield
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = .always
        emailTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailTextField.backgroundColor =  UIColor(white: 1, alpha: 0.5)
        emailTextField.text = "Email"
        emailTextField.textColor = .white
        emailTextField.layer.cornerRadius = 20
        
        
        
        //pasword text field
        let paddingView2: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        passwordTextField.leftView = paddingView2
        passwordTextField.leftViewMode = .always
        passwordTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextField.backgroundColor = UIColor(white: 1, alpha: 0.5)
        passwordTextField.text = "Password"
//        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.cornerRadius = 20
        
        
        //loginButton
        loginButton.setTitle("Login", for: .normal)
        loginButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.backgroundColor = UIColor(white: 1, alpha: 0.8)
        loginButton.setTitleColor(.purple, for: .normal)
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.cornerRadius = 20
        
        
        
        //dodaj elemente u stackView
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
     
    }
    
    @objc private func didTapButton(){
        dService.login(email: emailTextField.text!, password: passwordTextField.text!)
        loginButton.backgroundColor = UIColor(white: 1, alpha: 1)
        view.endEditing(true)
        
    }
    
    @objc private func didTapEmailTextField(){
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.white.cgColor
    }
    @objc private func didTapPasswordTextField(){
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        if(!passwordTextField.isSecureTextEntry){
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        }
    }
    @objc private func uiViewPressed(){
        view.endEditing(true)
        passwordTextField.layer.borderWidth = 0
        emailTextField.layer.borderWidth = 0
    }
    
    


}
