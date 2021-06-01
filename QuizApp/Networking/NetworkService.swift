import Foundation
import UIKit

class NetworkService: NetworkingProtocol{
    let defaults = UserDefaults()

    
    func executeUrlRequest<T: Codable>(_ request: URLRequest, completionHandler: @escaping
                                        (Result<T, RequestError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response,
                                                                   err in
            
            
            guard err == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.clientError))
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.serverError))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noData))
                }
                return
            }
            
            guard let value = try? JSONDecoder().decode(T.self, from: data) else{
                DispatchQueue.main.async {
                    completionHandler(.failure(.dataDecodingError))
                }
                return
            }
            DispatchQueue.main.async {
                completionHandler(.success(value))
            }
        }
        dataTask.resume()
    }
    
    
    
    func executeTimePostUrlRequest<T: Codable>(_ request: URLRequest, completionHandler: @escaping
                                                (Result<T, TimePostError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response,
                                                                   err in
            
            
            guard err == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.clientError))
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...404).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.serverError))
                }
                return
            }
            guard data != nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noData))
                }
                return
            }
            
            if(httpResponse.statusCode == 400){
                completionHandler(.failure(.BAD_REQUEST))
            }
            if(httpResponse.statusCode == 401){
                completionHandler(.failure(.UNAUTHORIZED))
            }
            if(httpResponse.statusCode == 403){
                completionHandler(.failure(.FORBIDDEN))
            }
            if(httpResponse.statusCode == 404){
                completionHandler(.failure(.NOT_FOUND))
            }
            
            if(httpResponse.statusCode == 200){
                DispatchQueue.main.async {
                    completionHandler(.success("Success" as! T))
                }
            }
        }
        dataTask.resume()
    }
    
    
    func fetchLogin(email: String, password: String) -> URLRequest{
    
        
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/session?username=\(email)&password=\(password)") else{
            fatalError("URL not working")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        return request
       
    }
    
    
    
    
    func fetchQuizzesFromNetwork()->URLRequest{
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/quizzes") else{
            fatalError("URL not working")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        return request
    }
    
    
    func fetchQuiz(quizID: Int, userID: Int, time: Double, numOfCorrect: Int, token: String)->URLRequest{
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/result") else{
            fatalError("URL not working")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        let json: [String : Any] = ["quiz_id": quizID, "user_id": userID, "time": time, "no_of_correct": numOfCorrect]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        return request
    }
    
    
    func fetchLeaderboardFromNetwork()-> URLRequest{
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "iosquiz.herokuapp.com"
        urlComponents.path = "/api/score"
        
        
        let queryItems = [URLQueryItem(name: "quiz_id", value: self.defaults.string(forKey: "quizID"))]
        urlComponents.queryItems = queryItems
        var request = URLRequest(url: urlComponents.url!)
        
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.addValue(self.defaults.string(forKey: "token")!, forHTTPHeaderField: "Authorization")
        return request
    }
    
    
    

}
    
    
    
    
    
    
    
    
    

