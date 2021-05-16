//
//  LoginViewDelegate.swift
//  QuizApp
//
//  Created by Antonio Markotic on 15.05.2021..
//

import Foundation
protocol LoginViewProtocol:NSObjectProtocol {
    func completed(id: Int, token: String)
    func showError()
}
