protocol QuizRepositoryProtocol {

    func fetchRemoteData(completionHandler: @escaping (Result<QuizResponse, RequestError>) -> Void)
    
    func saveToCoreData(quizzes: [Quiz])
    
    func fetchLocalData() -> [Quiz]
    
    func fetchCustomLocalData(with name: String) -> [Quiz]
}
