import Foundation

class NetworkService {
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
    
}
