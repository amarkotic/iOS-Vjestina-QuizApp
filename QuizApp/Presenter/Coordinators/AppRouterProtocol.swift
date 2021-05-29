//
//  AppRouterProtocol.swift
//  QuizApp
//
//  Created by Antonio Markotic on 07.05.2021..
//

import UIKit
protocol AppRouterProtocol {
    func setStartScreen(in window: UIWindow?)
    
    func showHomeScreen()
    
    func showLogin()
    
    func showQuiz(quiz: Quiz)
    
    func presentScore(numCorrect: Int, numTotal: Int)
    
    func popToRoot()
    
    func showLeaderboard()
    
    func dissmisLeaderBoard()
}
