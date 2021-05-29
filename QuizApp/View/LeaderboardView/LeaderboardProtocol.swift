//
//  LeaderboardProtocol.swift
//  QuizApp
//
//  Created by Antonio Markotic on 29.05.2021..
//

import Foundation
protocol LeaderboardProtocol:NSObjectProtocol {
    func populateList(recievedList : [LeaderboardResult])
}
