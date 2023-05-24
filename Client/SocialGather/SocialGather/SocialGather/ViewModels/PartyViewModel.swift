//
//  PartyViewModel.swift
//  SocialGather
//
//  Created by Edoardo Troianiello on 23/05/23.
//

import Foundation


final class PartyViewModel : ObservableObject {
    
    @Published var currentParty: Party = Party(code: "", name: "")
    
    @Published var isMaster = false
    
    @Published var questions: [Question] = []
    
    @Published var currentQuestion = 0
    
    @Published var player : Player = Player(name: "")
    static var shared = PartyViewModel()
    
    //MARK: Checked
    func createParty(name: String, completion: @escaping (Party?) -> Void) {
        let url = URL(string: "http://127.0.0.1:8080/createParty/")!
        let finalUrl = url.appendingPathComponent(name)

        var request = URLRequest(url: finalUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                // Handle error
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = data else {
                // Handle empty data
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase // Adjust the decoding strategy if needed

                let party = try decoder.decode(Party.self, from: data)
                print(party)
                DispatchQueue.main.async {
                    self.currentParty = party
                }
                completion(party)
            } catch {
                // Handle decoding error
                print("Decoding error:", error)
                completion(nil)
            }
        }.resume()
    }

    
    //MARK: Checked MA che rè kaàa
    func getParty(partyCode: String, completion: @escaping (Party?) -> Void) {
        let url = URL(string: "http://127.0.0.1:8080/parties/\(partyCode)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                // Handle error
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = data else {
                // Handle empty data
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase // Adjust the decoding strategy if needed

                let party = try decoder.decode(Party.self, from: data)
                completion(party)
            } catch {
                // Handle decoding error
                print("Decoding error:", error)
                completion(nil)
            }
        }.resume()
    }

    //MARK: Checked
    func getAllParties(completion: @escaping ([Party]?) -> Void){
        let url = URL(string: "http://127.0.0.1:8080/parties/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                // Handle error
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = data else {
                // Handle empty data
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase // Adjust the decoding strategy if needed

                let party = try decoder.decode([Party].self, from: data)
                print(party)
                completion(party)
            } catch {
                // Handle decoding error
                print("Decoding error:", error)
                completion(nil)
            }
        }.resume()
    }
    
    //MARK: Checked
    func joinAParty(partyCode: String,nickname: String, completion: @escaping (Bool) -> Void){
        let url = URL(string: "http://127.0.0.1:8080/joinParty/\(partyCode)")!
//        let partyCodeUrl = url.appendingPathComponent(partyCode)
        var urlComponents = URLComponents(url: url,resolvingAgainstBaseURL: false)

        // Create an array of URLQueryItem objects to represent the parameters
        let parameters: [URLQueryItem] = [
            URLQueryItem(name: "nickname", value: nickname)
        ]
        urlComponents?.queryItems = parameters

        // Get the final URL with the appended parameters
        guard let finalURL = urlComponents?.url else {
            fatalError("Failed to construct the final URL")
        }
        print(finalURL)
        var request = URLRequest(url: finalURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                print(response)
                if let response = response as? HTTPURLResponse,
                   response.statusCode == 200{
                    completion(true)
                } else if let response = response as? HTTPURLResponse,
                          response.statusCode == 418 {
                    print("already exist")
                   completion(false)
                }else{
                    print("Faliure")
                    completion(false)
                }
            }
        }.resume()
    }
    
    //MARK: Checked
    func startGame(partyCode: String, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "http://127.0.0.1:8080/start/")!
        let finalUrl = url.appendingPathComponent(partyCode)
        var request = URLRequest(url: finalUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse,
                   response.statusCode == 200{
                    completion(true)
                }else{
                    print("Faliure")
                    completion(false)
                }
            }
           
        }.resume()
    }
    
    //MARK: Checked
    func createATeam(partyCode: String,teamName: String, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "http://127.0.0.1:8080/createTeam/")!
        let finalUrl = url.appending(components: partyCode,teamName)
        var request = URLRequest(url: finalUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse,
                   response.statusCode == 200{
                    completion(true)
                }else{
                    print("Faliure")
                    completion(false)
                }
            }
           
        }.resume()
    }
    
    //MARK: Checked
    func createTeams(partyCode: String, teams: [Team], completion: @escaping (Bool) -> Void) {
        let url = URL(string: "http://127.0.0.1:8080/createTeams/\(partyCode)")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(teams)
            request.httpBody = jsonData
        } catch {
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(false)
                return
            }
            
            guard let data = data else {
                completion(false)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedQuestions = try decoder.decode([Team].self, from: data)
                completion(true)
            } catch {
                completion(false)
            }
        }.resume()
    }
    
    
    //MARK: Checked
    func getTeams(partyCode: String, completion: @escaping ([Team]?) -> Void){
            let url = URL(string: "http://127.0.0.1:8080/getTeams/")!
            let finalUrl = url.appending(components: partyCode)
            var request = URLRequest(url: finalUrl)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    // Handle error
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    // Handle empty data
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase // Adjust the decoding strategy if needed
                    
                    let teams = try decoder.decode([Team].self, from: data)
                    print(teams)
                    completion(teams)
                } catch {
                    // Handle decoding error
                    print("Decoding error:", error)
                    completion(nil)
                }
            }
            .resume()
        }

    
    
    

    //MARK: Checked
    func joinTeam(partyCode: String, teamName: String, playerName: String, completion: @escaping (Error?) -> Void) {
        let url = URL(string: "http://127.0.0.1:8080/joinTeam/\(partyCode)")!

        

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components!.queryItems = [
            URLQueryItem(name: "teamName", value: teamName),
            URLQueryItem(name: "nickName", value: playerName)
        ]

        // Get the final URL with the appended parameters
        guard let finalURL = components?.url else {
            fatalError("Failed to construct the final URL")
        }

        
        var request = URLRequest(url: finalURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                completion(error)
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(nil)
            } else {
                let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Request failed with status code: \(httpResponse.statusCode)"])
                completion(error)
            }
        }.resume()
    }

    

    //MARK: Checked
    func updateTeamPoints(partyCode: String, playerName: String, points: Int, teamName: String, completion: @escaping (Error?) -> Void) {
        let url = URL(string: "http://127.0.0.1:8080/teamPoint/\(partyCode)")!

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components!.queryItems = [
            URLQueryItem(name: "nickName", value: playerName),
            URLQueryItem(name: "points", value: "\(points)"),
            URLQueryItem(name: "teamName", value: teamName)
        ]

        guard let finalURL = components?.url else {
            fatalError("Failed to construct the final URL")
        }
        var request = URLRequest(url: finalURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                completion(error)
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(nil)
            } else {
                let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Request failed with status code: \(httpResponse.statusCode)"])
                completion(error)
            }
        }.resume()
    }

    
//
//        //MARK: - Player Routes-
//
    
    //MARK: Checked
    func getPlayer(playerID: UUID, partyID: UUID, teamName: String, completion: @escaping (Player?) -> Void){
    
    let url = URL(string: "http://127.0.0.1:8080/player/")!
    let partyCodeUrl = url.appendingPathComponent(playerID.uuidString)
    var urlComponents = URLComponents(url: partyCodeUrl,resolvingAgainstBaseURL: false)
    
    // Create an array of URLQueryItem objects to represent the parameters
    let parameters: [URLQueryItem] = [
        URLQueryItem(name: "partyID", value: partyID.uuidString),
        URLQueryItem(name: "teamName", value: teamName)
    ]
    urlComponents?.queryItems = parameters
    
    // Get the final URL with the appended parameters
    guard let finalURL = urlComponents?.url else {
        fatalError("Failed to construct the final URL")
    }
    
    var request = URLRequest(url: finalURL)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            // Handle error
            print(error.localizedDescription)
            completion(nil)
            return
        }
        
        guard let data = data else {
            // Handle empty data
            completion(nil)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase // Adjust the decoding strategy if needed
            
            let player = try decoder.decode(Player.self, from: data)
            print(player)
            completion(player)
        } catch {
            // Handle decoding error
            print("Decoding error:", error)
            completion(nil)
        }
    }.resume()
}

    //MARK: Checked l'ho fatta io
    func postPlayerPoint(partyCode: String, nickName: String, points: Int, completion: @escaping (Int?) -> Void) {
            let url = URL(string: "http://127.0.0.1:8080/playerPoint/")!
            let partyCodeUrl = url.appendingPathComponent(partyCode)
            var urlComponents = URLComponents(url: partyCodeUrl,resolvingAgainstBaseURL: false)
            
            // Create an array of URLQueryItem objects to represent the parameters
            let parameters: [URLQueryItem] = [
                URLQueryItem(name: "nickName", value: nickName),
                URLQueryItem(name: "points", value: String(points))
            ]
            urlComponents?.queryItems = parameters
            
            // Get the final URL with the appended parameters
            guard let finalURL = urlComponents?.url else {
                fatalError("Failed to construct the final URL")
            }
            
            var request = URLRequest(url: finalURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    // Handle error
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    // Handle empty data
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase // Adjust the decoding strategy if needed
                    
                    let points = try decoder.decode(Int.self, from: data)
                    print(points)
                    
                    completion(points)
                } catch {
                    // Handle decoding error
                    print("Decoding error:", error)
                    completion(nil)
                }
            }.resume()
        }
//
//        //MARK: - Leaderboard Routes -

    //MARK: checked l'ho modificata io
    func getPlayerLederboard(partyCode: String, completion: @escaping ([String:Int]?) -> Void){
            
            let url = URL(string: "http://127.0.0.1:8080/leaderboard/")!
            let finalUrl = url.appending(components: partyCode, "individual")
            
            var request = URLRequest(url: finalUrl)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    // Handle error
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    // Handle empty data
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase // Adjust the decoding strategy if needed
                    
                    let leaderboard = try decoder.decode([String:Int].self, from: data)
                    print(leaderboard)
                    completion(leaderboard)
                } catch {
                    // Handle decoding error
                    print("Decoding error:", error)
                    completion(nil)
                }
            }.resume()
        }

    
    
    //MARK: Checked l'ho modificata io
    func getTeamLederboard(partyCode: String, completion: @escaping ([String:Int]?) -> Void){
            
            let url = URL(string: "http://127.0.0.1:8080/leaderboard/")!
            let finalUrl = url.appending(components: partyCode, "team")
            
            var request = URLRequest(url: finalUrl)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    // Handle error
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    // Handle empty data
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase // Adjust the decoding strategy if needed
                    
                    let leaderboard = try decoder.decode([String:Int].self, from: data)
                    print(leaderboard)
                    completion(leaderboard)
                } catch {
                    // Handle decoding error
                    print("Decoding error:", error)
                    completion(nil)
                }
            }.resume()
        }
    
//
//
//        //MARK: - Questions Routes -
//
    //MARK: Checked 
    
    func postQuestions(partyCode: String, questions: [Question], completion: @escaping (Bool) -> Void) {
        let url = URL(string: "http://127.0.0.1:8080/postQuestions/\(partyCode)")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(questions)
            request.httpBody = jsonData
        } catch {
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(false)
                return
            }
            
            guard let data = data else {
                completion(false)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedQuestions = try decoder.decode([Question].self, from: data)
                completion(true)
            } catch {
                completion(false)
            }
        }.resume()
    }



    func getQuestion(partyCode: String, index: Int, completion: @escaping (Question?) -> Void) {
            let url = URL(string: "http://127.0.0.1:8080/question/")!
            let finalUrl = url.appending(components: partyCode, String(index))
            
            var request = URLRequest(url: finalUrl)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    // Handle error
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    // Handle empty data
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase // Adjust the decoding strategy if needed
                    
                    let question = try decoder.decode(Question.self, from: data)
                    print(question)
                    
                    completion(question)
                } catch {
                    // Handle decoding error
                    print("Decoding error:", error)
                    completion(nil)
                }
            }.resume()
        }
    
    //MARK: Checked BRavo Airby ma era una cacata
    func getAllQuestions(completion: @escaping ([Question]?) -> Void){
            let url = URL(string: "http://127.0.0.1:8080/questionBank/")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    // Handle error
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    // Handle empty data
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase // Adjust the decoding strategy if needed
                    
                    let questions = try decoder.decode([Question].self, from: data)
                    print(questions)
                    completion(questions)
                } catch {
                    // Handle decoding error
                    print("Decoding error:", error)
                    completion(nil)
                }
            }.resume()
        }
    
}
