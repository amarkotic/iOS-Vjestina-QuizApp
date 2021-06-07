//
//  SearchViewProtocol.swift
//  QuizApp
//
//  Created by Antonio Markotic on 01.06.2021..
//
import UIKit
protocol SearchViewProtocol:NSObjectProtocol {
    func fetchSuccessful(matrix: [[Quiz]], uniqueSectionArray: [QuizCategory], quizzArray: [Quiz])
}
