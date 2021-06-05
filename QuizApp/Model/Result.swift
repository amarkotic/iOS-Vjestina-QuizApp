//
//  Result.swift
//  QuizApp
//
//  Created by Antonio Markotic on 15.05.2021..
//

import Foundation
enum Result<Success, Failure> where Failure: Error{
    case success(Success)
    case failure(Failure)
}
