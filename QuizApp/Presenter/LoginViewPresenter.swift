//
//  LoginViewPresenter.swift
//  QuizApp
//
//  Created by Antonio Markotic on 15.05.2021..
//

import Foundation
import UIKit


class LoginViewPresenter {
    
    let defaults = UserDefaults()
    private let nService : NetworkService
    weak private var loginViewDelegate : LoginViewController?
    
    
    init(networking: NetworkService){
        self.nService = networking
    }
    func setLoginViewDelegate(loginViewDelegate : LoginViewController?){
        self.loginViewDelegate = loginViewDelegate
    }
    
    
    
    
    func login(email: String, password: String){
        let request = nService.fetchLogin(email: email, password: password)
        nService.executeUrlRequest(request){ (result: Result<LoginResponse,RequestError>)  in
            
            switch result {
            
            case .failure(let error):
                print(error)
                self.loginViewDelegate?.showError()
            case .success(let value):
                print(value)
                self.defaults.set(value.id, forKey : "id")
                self.defaults.set(value.token, forKey: "token")
                self.loginViewDelegate?.completed()
                
            }
        }
    }
}






