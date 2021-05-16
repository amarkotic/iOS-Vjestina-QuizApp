//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 14.04.2021..
//

import UIKit
import SnapKit

class LoginViewController: UIViewController, LoginViewProtocol {
    
    let quizNameLabel: UILabel = UILabel()
    
    let stackView : UIStackView = UIStackView()
    let emailTextField: UITextField = UITextField()
    let passwordTextField: UITextField = UITextField()
    let loginButton : UIButton = UIButton()
    let defaults = UserDefaults()
  
    let nService = NetworkService()
    private let loginViewPresenter = LoginViewPresenter(networking: NetworkService())
    private var router: AppRouter!
    convenience init(router: AppRouter) {
        self.init()
        self.router = router
    }
    
  
    
    private var gradientLayer:CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //UI
        setGradientBackground()
        view.layer.insertSublayer(gradientLayer, at: 0)
        setConstraints()
        loadElements()
        
        loginViewPresenter.setLoginViewDelegate(loginViewDelegate: self)
        
        //skrivanje tipkovnice i odznačivanje textfieldova
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(uiViewPressed))
        view.addGestureRecognizer(tap)
        
        //funkcionalnost
        loginButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        emailTextField.addTarget(self, action: #selector(didTapEmailTextField), for: .editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(didTapPasswordTextField), for: .editingDidBegin)
    }
    
    func setGradientBackground(){
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 4.0, y: 1.0)

    }
    
    func setConstraints(){
        
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
    private func loadElements(){

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
    
    
    @objc private func didTapButton(){
        view.endEditing(true)
        loginViewPresenter.login(email: emailTextField.text!, password: passwordTextField.text!, loginButton: loginButton)
    }
    
    
    //označi stisnuti textField
    @objc private func didTapEmailTextField(){
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.borderWidth = 0
    }
    @objc private func didTapPasswordTextField(){
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        emailTextField.layer.borderWidth = 0
        if(!passwordTextField.isSecureTextEntry){
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    //odznači oba textFielda
    @objc private func uiViewPressed(){
        view.endEditing(true)
        passwordTextField.layer.borderWidth = 0
        emailTextField.layer.borderWidth = 0
    }
    
    func showError(){
        let alert = UIAlertController(title: "No account found", message: "Please try again", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func completed(id: Int, token: String){
        defaults.set(id, forKey : "id")
        defaults.set(token, forKey: "token")
        router.showHomeScreen()
    }
    
}
