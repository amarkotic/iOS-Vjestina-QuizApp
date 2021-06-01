struct Quiz :Codable, Equatable{
 
    let id: Int
    let title: String
    let description: String
    let category: QuizCategory
    let level: Int
    let imageUrl: String
    var questions: [Question]

    enum CodingKeys:String, CodingKey{
        case id
        case title
        case description
        case category
        case level
        case imageUrl = "image"
        case questions
    }
    
    static func == (lhs: Quiz, rhs: Quiz) -> Bool {
        return lhs.id == rhs.id
    }
    

}
