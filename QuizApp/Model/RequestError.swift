//
//  RequestError.swift
//  QuizApp
//
//  Created by Antonio Markotic on 15.05.2021..
//

import Foundation
enum RequestError: Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
    case UNAUTHORIZED
    case FORBIDDEN
    case NOT_FOUND
    case BAD_REQUEST
    case OK
}
