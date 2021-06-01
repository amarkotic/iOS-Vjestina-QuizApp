import CoreData

class QuizDataRepository: QuizRepositoryProtocol {
    private let networkDataSource: NetworkDataSourceProtocol
    private let coreDataSource: QuizCoreDataSourceProtocol
    private let coreDataContext : NSManagedObjectContext
    
    init (networkDataSource: NetworkDataSourceProtocol, coreDataSource: QuizCoreDataSourceProtocol){
        self.networkDataSource = networkDataSource
        self.coreDataSource = coreDataSource
        self.coreDataContext = CoreDataStack(modelName: "QuizAppModel").managedContext
    }
    
    
    
    func fetchRemoteData(completionHandler: @escaping (Result<QuizResponse, RequestError>) -> Void){

        networkDataSource.fetchQuizzesFromNetwork(completionHandler: completionHandler)

    }
    
    func saveToCoreData(quizzes: [Quiz]){
        coreDataSource.saveNewQuizzesToCoreData(quizzes: quizzes)
    }
    
    
    func fetchLocalData() -> [Quiz] {
        return coreDataSource.fetchAllQuizzesFromCoreData()

    }
    
    func fetchCustomLocalData(with name: String) -> [Quiz]{
        return coreDataSource.fetchFilteredQuizzesFromCoreData(with : name)
    }
    
    
}
