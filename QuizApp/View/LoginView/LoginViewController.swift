//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 14.04.2021..
//

import UIKit
import SnapKit

class LoginViewController: UIViewController, LoginViewProtocol {
    
    var gradientLayer:CAGradientLayer!

    let quizNameLabel: UILabel = UILabel()
    
    let stackView : UIStackView = UIStackView()
    let emailTextField: UITextField = UITextField()
    let passwordTextField: UITextField = UITextField()
    let loginButton : UIButton = UIButton()
    
   
    
    private let loginViewPresenter = LoginViewPresenter(networking: NetworkService())
    private var router: AppRouter!
    convenience init(router: AppRouter) {
        self.init()
        self.router = router
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewPresenter.setLoginViewDelegate(loginViewDelegate: self)
        
        //UI
        buildViews()
        
        //skrivanje tipkovnice i odznačivanje textfieldova
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(uiViewPressed))
        view.addGestureRecognizer(tap)
        
        //funkcionalnost
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        emailTextField.addTarget(self, action: #selector(didTapEmailTextField), for: .editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(didTapPasswordTextField), for: .editingDidBegin)
    }
    
    
    @objc private func didTapLoginButton(){
        view.endEditing(true)
        loginButton.backgroundColor = UIColor(white: 1, alpha: 1)
        loginViewPresenter.login(email: emailTextField.text!, password: passwordTextField.text!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [] in
            self.loginButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        }
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
    
    //login not successful
    func showError(){
        let alert = UIAlertController(title: "No account found", message: "Please try again", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //login successful
    func completed(){
        router.showHomeScreen()
    }
    
}
