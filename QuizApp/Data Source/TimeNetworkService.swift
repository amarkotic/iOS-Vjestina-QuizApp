//import Foundation
//
//class TimeNetworkService {
//    func executeUrlRequest<T: Codable>(_ request: URLRequest, completionHandler: @escaping
//                            (Result<T, TimePostError>) -> Void) {
//  
//        let dataTask = URLSession.shared.dataTask(with: request) { data, response,
//                                                                   err in
//           
//            guard err == nil else {
//                DispatchQueue.main.async {
//                    completionHandler(.failure(.BAD_REQUEST))
//                }
//                return
//            }
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//                DispatchQueue.main.async {
//                    completionHandler(.failure(.serverError))
//                }
//                return
//            }
//            guard let data = data else {
//                DispatchQueue.main.async {
//                    completionHandler(.failure(.noData))
//                }
//                return
//            }
//        
//            guard let value = try? JSONDecoder().decode(T.self, from: data) else{
//                DispatchQueue.main.async {
//                    completionHandler(.failure(.dataDecodingError))
//                }
//                return
//            }
//            DispatchQueue.main.async {
//                completionHandler(.success(value))
//            }
//        }
//        dataTask.resume()
//    }
//}
