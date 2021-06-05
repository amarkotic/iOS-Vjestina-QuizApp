//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 14.04.2021..
//

import UIKit
import SnapKit
import Reachability

class QuizzesViewController: UIViewController, QuizzesViewProtocol {
    
    
    //fiksni dio
    let quizNameLabel: UILabel = UILabel()
    let getQuizzButton = UIButton()
    
    //error stack
    var errorStack = UIStackView()
    let errorImageView = UIImageView()
    let errorTitle = UILabel()
    let errorDescription1 = UILabel()
    let errorDescription2 = UILabel()

    
    //fun fact stack
    let funFactStack  = UIStackView()
    let bulbStackView = UIStackView()
    var bulbImage = UIImage()
    let bulbImageView = UIImageView()
    let funFactLabel = UILabel()
    let funFactDescription: UILabel = UILabel()
    
    var tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
    
    //array kvizova
    var quizzArray :[Quiz] = []
    
    
    //array kategorija
    var uniqueSectionArray = [QuizCategory]()
    
    //2-d matrica popunjena s kvizovima sortiranim prema kategorijama
    var matrix = [[Quiz]]()
    var colorOfCategory =  [UIColor]()
    var firstLoad = false
    
    private var gradientLayer:CAGradientLayer!
  
    let reachability = try! Reachability()
    var internetConnection = false
    
    
    let nService = NetworkService()
    private let quizzesViewPresenter = QuizzesViewPresenter(networking: NetworkService())
    
    private var router: AppRouter!
    convenience init(router: AppRouter) {
        self.init()
        self.router = router
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizzesViewPresenter.setquizzesViewDelegate(quizzesViewDelegate: self)
        
        //pokretanje provjere interneta
        checkInternetConnection()
       
        //UI
        buildViewsBeforeFetch()
        
        //funkcionalnost
        getQuizzButton.addTarget(self, action: #selector(getQuizzPressed), for: .touchUpInside)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    
    func checkInternetConnection(){
        if reachability.isReachable{
            internetConnection = true
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }


    @objc func getQuizzPressed(){
        if internetConnection == true{
            quizzesViewPresenter.fetchQuizzes()
            if (firstLoad != true){
                buildViewsAfterFetch()
            }
        }
    }
    
    
    
    func fetchSuccessful(matrix: [[Quiz]], uniqueSectionArray: [QuizCategory], quizzArray: [Quiz]){
        self.matrix = matrix
        self.uniqueSectionArray = uniqueSectionArray
        self.quizzArray = quizzArray
        firstLoad = true

        tableView.reloadData()
        funFactDescription.text = String(format: "%@ %d %@", "There are", quizzArray.flatMap{$0.questions}.filter{$0.question.contains("NBA")}.count, "questions that contain the word NBA")
   
        errorStack.isHidden = true
        funFactStack.isHidden = false
        tableView.isHidden = false
        
        for j in 0..<uniqueSectionArray.count{
            
            let  col = UIColor()
            colorOfCategory.append(col)
            colorOfCategory[j] = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
        }
        
    }
    

    
}



//Table view Delegate methods
extension QuizzesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //prikazi kviz
        router.showQuiz(quiz: matrix[indexPath.section][indexPath.row])
        
    }
}


//Table view Data Source methods
extension QuizzesViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "      \(uniqueSectionArray[section].rawValue)"
        label.textColor = colorOfCategory[section]
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return matrix.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matrix[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizzCell") as! TableViewCell
        cell.backgroundColor = .purple
        
        let quiz = matrix[indexPath.section][indexPath.row]
        
        cell.set(quiz:quiz, color: colorOfCategory[indexPath.section])
        return cell
    }
}
