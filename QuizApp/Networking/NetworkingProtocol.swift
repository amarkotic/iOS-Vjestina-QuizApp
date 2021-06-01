//
//  NetworkingProtocol.swift
//  QuizApp
//
//  Created by Antonio Markotic on 15.05.2021..
//
import UIKit
protocol NetworkingProtocol {

    func fetchLogin(email: String, password: String) -> URLRequest

    func fetchQuizzesFromNetwork()->URLRequest

    func fetchQuiz(quizID: Int, userID: Int, time: Double, numOfCorrect: Int, token: String)->URLRequest
    
    func fetchLeaderboardFromNetwork()-> URLRequest
}
