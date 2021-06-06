//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 14.04.2021..
//

import UIKit
import SnapKit
import Reachability


class LoginViewController: UIViewController, LoginViewProtocol {
    
    var gradientLayer:CAGradientLayer!
    
    let quizNameLabel = UILabel()
    let noInternetLabel = UILabel()
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    
    let reachability = try! Reachability()
    var internetConnection = false
    
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

        //obavijesti korisnika o dostupnosti interneta
        if reachability.connection != .unavailable{
            noInternetLabel.isHidden = true
            loginViewPresenter.login(email: emailTextField.text!, password: passwordTextField.text!)
        }else{
            noInternetLabel.isHidden = false
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
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
        removeElements()

        DispatchQueue.main.asyncAfter(deadline: .now()+0.9) {
            self.router.showHomeScreen()
        }

    }
    
}



//Animations

extension LoginViewController{
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        quizNameLabel.transform = quizNameLabel.transform.scaledBy(x: 0, y: 0)
        emailTextField.transform = emailTextField.transform.translatedBy(x: -view.frame.width, y: 0)
        passwordTextField.transform = passwordTextField.transform.translatedBy(x: -view.frame.width, y: 0)
        loginButton.transform = loginButton.transform.translatedBy(x: -view.frame.width, y: 0)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: { [self] in
                        quizNameLabel.alpha = 1
                        quizNameLabel.transform = .identity
                        self.view.layoutIfNeeded()
                       }
        )
        
        UIView.animate(withDuration: 1.5,
                       delay: 0.25,
                       options: [.curveEaseInOut],
                       animations: { [self] in
                        emailTextField.alpha = 1
                        emailTextField.transform = .identity
                        self.view.layoutIfNeeded()
                       }
        )
        
        UIView.animate(withDuration: 1.5,
                       delay: 0.5,
                       options: [.curveEaseInOut],
                       animations: { [self] in
                        passwordTextField.alpha = 1
                        passwordTextField.transform = .identity
                        self.view.layoutIfNeeded()
                       }
        )
        UIView.animate(withDuration: 1.5,
                       delay: 0.75,
                       options: [.curveEaseInOut],
                       animations: { [self] in
                        loginButton.alpha = 1
                        loginButton.transform = .identity
                        self.view.layoutIfNeeded()
                       }
        )
        
    }
    
    func removeElements(){
        UIView.animate(withDuration: 0.75,
                       delay: 0.0,
                       options: [.curveEaseInOut],
                       animations: { [self] in
                        quizNameLabel.transform = quizNameLabel.transform.translatedBy(x: 0, y: -view.frame.height)
                        self.view.layoutIfNeeded()
                       }
        )
        UIView.animate(withDuration: 0.75,
                       delay: 0.25,
                       options: [.curveEaseInOut],
                       animations: { [self] in
                        emailTextField.transform = emailTextField.transform.translatedBy(x: 0, y: -view.frame.height)
                        self.view.layoutIfNeeded()
                       }
        )
        UIView.animate(withDuration: 0.75,
                       delay: 0.5,
                       options: [.curveEaseInOut],
                       animations: { [self] in
                        passwordTextField.transform = passwordTextField.transform.translatedBy(x: 0, y: -view.frame.height)
                        self.view.layoutIfNeeded()
                       }
        )
        UIView.animate(withDuration: 0.75,
                       delay: 0.75,
                       options: [.curveEaseInOut],
                       animations: { [self] in
                        loginButton.transform = loginButton.transform.translatedBy(x: 0, y: -view.frame.height)
                        self.view.layoutIfNeeded()
                       }
        )
    }
    
}
