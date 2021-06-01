//
//  NetworkDataSourceProtocol.swift
//  QuizApp
//
//  Created by Antonio Markotic on 31.05.2021..
//

protocol NetworkDataSourceProtocol {
    func fetchQuizzesFromNetwork(completionHandler: @escaping (Result<QuizResponse, RequestError>) -> Void)
}
