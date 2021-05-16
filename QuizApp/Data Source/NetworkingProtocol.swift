//
//  NetworkingProtocol.swift
//  QuizApp
//
//  Created by Antonio Markotic on 15.05.2021..
//
protocol NetworkingProtocol {

    func login(email: String, password: String) -> LoginStatus

    func fetchQuizes() -> [Quiz]

}
