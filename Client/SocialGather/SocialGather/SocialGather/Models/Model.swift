//
//  Model.swift
//  SocialGather
//
//  Created by Edoardo Troianiello on 23/05/23.
//

import Foundation

struct Party : Codable {
    var id: UUID?
    var code: String
    var partyName:  String
    var isGameStarted: Bool
    var teams: [Team]
    var players: [Player]
    var teamLeaderBoard: [String : Int]
    var playerLeaderBoard: [String : Int]
    var questions: [Question]

    init(code: String,name: String, isGameStarted: Bool = false, teams: [Team] = [], players: [Player] = []) {
        self.id = UUID()
        self.code = code
        self.partyName = name
        self.isGameStarted = isGameStarted
        self.teams = teams
        self.players = players
        self.teamLeaderBoard = [:]
        self.playerLeaderBoard = [:]
        self.questions = []
    }
}

struct Player: Codable {
    var id: UUID?
    var name: String
    var score: Int
    var teamID: UUID?

    init(name: String, score: Int = 0, teamID: UUID? = nil) {
        self.id = UUID()
        self.name = name
        self.score = score
        self.teamID = teamID
    }
}

struct Team: Codable {
    var id: UUID?
    var name: String
    var players: [Player]

    init(name: String, players: [Player] = []) {
        self.id = UUID()
        self.name = name
        self.players = players
    }
}

struct Question:  Codable, Equatable, Hashable {
//    var id: UUID?
    var text: String
    var answers: [String]
    var correctAnswer: String

    init(text: String, answers: [String], correctAnswer: String) {
//        self.id = UUID()
        self.text = text
        self.answers = answers
        self.correctAnswer = correctAnswer
    }
}

//struct Answer: Content {
//    var id: UUID?
//    var questionID: UUID
//    var playerID: UUID
//    var selectedAnswer: String
//
//    init(questionID: UUID, playerID: UUID, selectedAnswer: String) {
//        self.id = UUID()
//        self.questionID = questionID
//        self.playerID = playerID
//        self.selectedAnswer = selectedAnswer
//    }
//}
//
//struct LeaderboardEntry: Content {
//    var id: UUID?
//    var playerName: String
//    var score: Int
//
//    init(playerName: String, score: Int) {
//        self.id = UUID()
//        self.playerName = playerName
//        self.score = score
//    }
//}
