//
//  QuizzesViewProtocolk.swift
//  QuizApp
//
//  Created by Antonio Markotic on 16.05.2021..
//

import Foundation

protocol QuizzesViewProtocol:NSObjectProtocol {
    func fetchSuccessful(matrix: [[Quiz]], uniqueSectionArray: [QuizCategory], quizzArray: [Quiz])
}
