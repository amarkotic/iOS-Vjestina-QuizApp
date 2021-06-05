//
//  TimePostError.swift
//  QuizApp
//
//  Created by Antonio Markotic on 16.05.2021..
//

import Foundation
enum TimePostError: Error {
    case clientError
    case serverError
    case noData
    case UNAUTHORIZED
    case FORBIDDEN
    case NOT_FOUND
    case BAD_REQUEST
    case OK
}
