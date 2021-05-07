//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 14.04.2021..
//

import UIKit

class LoginViewController: UIViewController {
    
    let quizNameLabel: UILabel = UILabel()
    
    let stackView : UIStackView = UIStackView()
    let emailTextField: UITextField = UITextField()
    let passwordTextField: UITextField = UITextField()
    let loginButton : UIButton = UIButton()
    
    let dService = DataService()
    
    
    private var gradientLayer:CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradientBackground()
        view.layer.insertSublayer(gradientLayer, at: 0)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    func setGradientBackground(){
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 4.0, y: 1.0)

    }
    
    private func loadElements(){
        
        
        //PopQuiz label
        quizNameLabel.translatesAutoresizingMaskIntoConstraints = false
        quizNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        quizNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant :30 ).isActive = true
        quizNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        quizNameLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        quizNameLabel.text = "PopQuiz"
        quizNameLabel.font = UIFont(name: "Futura", size: 40)
        quizNameLabel.textAlignment = NSTextAlignment.center
        
        
        
        //main stackview
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution  = .equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 20.0
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.topAnchor.constraint(equalTo: quizNameLabel.bottomAnchor, constant: 40).isActive = true
        
        
        //emailtextfield
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = .always
        emailTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailTextField.backgroundColor =  UIColor(white: 1, alpha: 0.5)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email")
        emailTextField.textColor = .white
        emailTextField.layer.cornerRadius = 20
        
        
        //pasword text field
        let paddingView2: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        passwordTextField.leftView = paddingView2
        passwordTextField.leftViewMode = .always
        passwordTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextField.backgroundColor = UIColor(white: 1, alpha: 0.5)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password")
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.cornerRadius = 20
        
        
        //loginButton
        loginButton.setTitle("Login", for: .normal)
        loginButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
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
        
        loginButton.backgroundColor = UIColor(white: 1, alpha: 1)
        view.endEditing(true)
        
        
        let a = dService.login(email: emailTextField.text!, password: passwordTextField.text!)
        switch a {
        
        case .success:
            //prijava je uspješna
            let qvc = UINavigationController(rootViewController: QuizzesViewController())
            let svc = SettingsViewController()
            
            //tabbar[QuizzesViewControler, SettingsViewController]
            let tabbar = UITabBarController()
            tabbar.viewControllers = [qvc, svc]
            
            //izgled tabBar-a
            qvc.tabBarItem.image = UIImage(named: "Quizz")
            qvc.tabBarItem.title = "Quiz"
            svc.tabBarItem.image = UIImage(named: "Settings")
            svc.tabBarItem.title = "Settings"
            tabbar.tabBar.barTintColor = .white
            tabbar.tabBar.tintColor = .purple
            
            tabbar.modalPresentationStyle = .fullScreen
            present(tabbar, animated: true, completion: nil)
            
            //osvježi textFieldove
            emailTextField.text = ""
            passwordTextField.text = ""
            
            
        case .error(400, "Bad Request"):
            //prijava nije uspješna
            
            //obavijesti korisnika
            let alert = UIAlertController(title: "No account found", message: "Please try again", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        default:
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
        loginButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)
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
    
    
    
    
}
