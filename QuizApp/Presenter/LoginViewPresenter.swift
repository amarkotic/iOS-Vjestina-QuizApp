//
//  LoginViewPresenter.swift
//  QuizApp
//
//  Created by Antonio Markotic on 15.05.2021..
//

import Foundation
import UIKit


class LoginViewPresenter {

    
    private let nService : NetworkService
    weak private var loginViewDelegate : LoginViewController?
   

    init(networking: NetworkService){
        self.nService = networking
    }
    func setLoginViewDelegate(loginViewDelegate : LoginViewController?){
        self.loginViewDelegate = loginViewDelegate
    }
    
    
    
    func login(email: String, password: String, loginButton: UIButton){
        
        loginButton.backgroundColor = UIColor(white: 1, alpha: 1)
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/session?username=\(email)&password=\(password)") else{
            fatalError("URL not working")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        
        
        nService.executeUrlRequest(request){ (result: Result<LoginResponse,RequestError>)  in
            
            
            switch result {

            case .failure(let error):
                print(error)
                self.loginViewDelegate?.showError()
            case .success(let value):
                print(value)
                self.loginViewDelegate?.completed(id: value.id, token: value.token)
              
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [] in
        loginButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)

        }
            
       
    }
 
    
    
}
