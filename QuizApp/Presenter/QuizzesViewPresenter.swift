//
//  QuizzesViewPresenter.swift
//  QuizApp
//
//  Created by Antonio Markotic on 16.05.2021..
//


import UIKit
import CoreData


class QuizzesViewPresenter{
    private let nService : NetworkService
    weak private var quizzesViewDelegate : QuizzesViewController?
    
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
    func setquizzesViewDelegate(quizzesViewDelegate : QuizzesViewController?){
        self.quizzesViewDelegate = quizzesViewDelegate
    }
    
    
    
    
    func fetchQuizzes(with internetConnection: Bool){
        if (internetConnection ){
            
            print("Ima internetske veze")
            DispatchQueue.global().async {
                self.repository.fetchRemoteData {(result: Result<QuizResponse, RequestError>) in
                    switch result{
                    case .failure(let error):
                        print(error)
                        
                    case .success(let value):
                        
                        //spremiti dohvaćeno novo u Core datu
                        
                        self.quizzArray = value.quizzes
                        self.repository.saveToCoreData(quizzes: self.quizzArray)
                        
                        
                        self.loadDataFromCoreData()
                    }
                }
            }
        }else{
            print("Nema internetske veze")
            loadDataFromCoreData()
        }
    }
    
    
    func loadDataFromCoreData(){
        
        //fetch iz core data-e i slanje TIH podataka view-u za prikaz
        quizzArray = repository.fetchLocalData()
        populateMatrix(quiz: quizzArray, firstLoad: self.firstLoad)
        self.quizzesViewDelegate?.fetchSuccessful(matrix: self.matrix, uniqueSectionArray: self.uniqueSectionArray, quizzArray: self.quizzArray)

        self.firstLoad = true
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
