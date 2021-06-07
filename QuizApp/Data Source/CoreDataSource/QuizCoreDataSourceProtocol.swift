//
//  QuizCoreDataSourceProtocol.swift
//  QuizApp
//
//  Created by Antonio Markotic on 31.05.2021..
//

protocol QuizCoreDataSourceProtocol {
    func fetchAllQuizzesFromCoreData() -> [Quiz]
    func saveNewQuizzesToCoreData(quizzes: [Quiz])
    func fetchFilteredQuizzesFromCoreData(with name: String) -> [Quiz]
}
