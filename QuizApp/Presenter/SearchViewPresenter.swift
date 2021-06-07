//
//  SearchViewPresenter.swift
//  QuizApp
//
//  Created by Antonio Markotic on 01.06.2021..
//

import Foundation
import UIKit
class SearchViewPresenter {
    
 
    private let nService : NetworkService
    weak private var searchViewDelegate : SearchViewController?
    
    let repository = QuizDataRepository(networkDataSource: NetworkDataSource(), coreDataSource: QuizCoreDataSource(coreDataContext: CoreDataStack(modelName: "QuizAppModel").managedContext))
    //array kvizova
    var quizzArray :[Quiz] = []
    
    //array kategorija
    var uniqueSectionArray = [QuizCategory]()
    
    //2-d matrica popunjena s kvizovima sortiranim prema kategorijama
    var matrix = [[Quiz]]()
    var colorOfCategory =  [UIColor]()
    
    var firstLoad = false
    
   
    
    
    init(networking: NetworkService){
        self.nService = networking
    }
    func setSearchViewDelegate(searchViewDelegate : SearchViewController?){
        self.searchViewDelegate = searchViewDelegate
    }
    
    
    
    func fetchQuizzesFromCD(with name: String){
        matrix.removeAll()
        quizzArray = repository.fetchCustomLocalData(with: name)
        populateMatrix(quiz: quizzArray, firstLoad: self.firstLoad)
       
        self.searchViewDelegate?.fetchSuccessful(matrix: self.matrix, uniqueSectionArray: self.uniqueSectionArray, quizzArray: self.quizzArray)
       
    }
    
    
    
    //popuni 2-d tablicu quiz-ovima dohvaćenim s API-a
    func populateMatrix(quiz: [Quiz], firstLoad: Bool){
        quizzArray = quiz
        if(firstLoad == false){
            let sections = quizzArray.compactMap{$0.category}
            uniqueSectionArray = Array(Set(sections))
        }
        let length = uniqueSectionArray.count
        //iteriraj po svakoj kategoriji
        for j in 0..<length{
            let group = [Quiz]()
            if(firstLoad == false){
                matrix.append(group)
            }
            
            let currentSection = uniqueSectionArray[j]
            //iteriraj po svim kvizovima i dodaj ih u stupac matrice za konkretnu kategoriju
            for i in 0..<quizzArray.count{
                if (quizzArray[i].category == currentSection){
                    if !matrix[j].contains(quizzArray[i]){
                        matrix[j].append(quizzArray[i])
                    }
                }
            }
        }
    }
}
