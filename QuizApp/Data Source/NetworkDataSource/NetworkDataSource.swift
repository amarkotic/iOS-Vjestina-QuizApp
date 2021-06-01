//
//  NetworkDataSource.swift
//  QuizApp
//
//  Created by Antonio Markotic on 31.05.2021..
//
import UIKit

class NetworkDataSource: NetworkDataSourceProtocol{
    
    
    let nService = NetworkService()
    
    func fetchQuizzesFromNetwork(completionHandler: @escaping (Result<QuizResponse, RequestError>) -> Void) {
       
        let request = self.nService.fetchQuizzesFromNetwork()
        nService.executeUrlRequest(request, completionHandler: completionHandler)
        
    }
    
    
    
    
    
}



