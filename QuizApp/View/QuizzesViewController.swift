//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 14.04.2021..
//

import UIKit
import SnapKit
import Reachability

class QuizzesViewController: UIViewController {
    
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
        
        if reachability.isReachable{
            internetConnection = true
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        quizzesViewPresenter.setquizzesViewDelegate(quizzesViewDelegate: self)
        
        //UI
        setConstraintsBeforeGetQuizzPressed()
        loadElementsBeforeGetQuizzPressed()
        
        setConstraintsAfterGetQuizzPressed()
        loadElementsAfterGetQuizzPressed()
    
        //funkcionalnost
        getQuizzButton.addTarget(self, action: #selector(getQuizzPressed), for: .touchUpInside)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setConstraintsBeforeGetQuizzPressed(){
        
        //popQuizLabel
        view.addSubview(quizNameLabel)
        quizNameLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 200, height: 100))
            make.top.equalTo(view).offset(20)
            make.centerX.equalTo(view)
        }
        
        //getquizbutton
        view.addSubview(getQuizzButton)
        getQuizzButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: view.frame.width * 0.8, height: 40))
            make.top.equalTo(quizNameLabel.snp.bottom).offset(0)
            make.centerX.equalTo(view)
        }
        
        //errorstack
        view.addSubview(errorStack)
        errorStack.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: view.frame.width * 0.8, height: view.frame.height * 0.35))
            make.centerX.centerY.equalTo(view)
            
        }
        
    }
    
    
    
    func loadElementsBeforeGetQuizzPressed(){
        
        view.backgroundColor = .purple
        self.navigationController?.navigationBar.isHidden = true
        
        //quizName
        quizNameLabel.text = "PopQuiz"
        quizNameLabel.font = UIFont(name: "Futura", size: 30)
        quizNameLabel.textAlignment = NSTextAlignment.center
        
        //quizButton
        getQuizzButton.setTitle("Get Quizz", for: .normal)
        getQuizzButton.backgroundColor = UIColor(white: 1, alpha: 1)
        getQuizzButton.setTitleColor(.purple, for: .normal)
        getQuizzButton.layer.cornerRadius = 20
        
        
        //error stack
        errorStack.distribution  = UIStackView.Distribution.fillProportionally
        errorStack.alignment = UIStackView.Alignment.center
        errorStack.spacing   = 0.0
        errorStack.axis = NSLayoutConstraint.Axis.vertical
        
        //četiri elementa errorstackview-a
        errorImageView.image = UIImage(named: "error")
        errorImageView.contentMode = .scaleAspectFit
        errorTitle.text = "Error\n"
        errorTitle.font = UIFont.boldSystemFont(ofSize: 27)
        errorDescription1.text = "Data can't be reached."
        errorDescription2.text = "Please try again"
        
        //dodaj elemente u stackView
        errorStack.addArrangedSubview(errorImageView)
        errorStack.addArrangedSubview(errorTitle)
        errorStack.addArrangedSubview(errorDescription1)
        errorStack.addArrangedSubview(errorDescription2)
    }
    
    
    
    
    func setConstraintsAfterGetQuizzPressed(){
        
        //fun fact stack ispod kojeg dolaze kvizovi
        view.addSubview(funFactStack)
        funFactStack.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(getQuizzButton.snp.bottom).offset(30)
        }
        
        view.addSubview(bulbImageView)
        bulbImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView = UITableView(frame: CGRect(x: 0, y: 280, width: view.bounds.width, height: view.bounds.height-280))
        
    }
    func loadElementsAfterGetQuizzPressed(){
        //funfact stack
        funFactStack.distribution  = UIStackView.Distribution.equalSpacing
        funFactStack.alignment = UIStackView.Alignment.leading
        funFactStack.spacing   = 15.0
        funFactStack.axis = NSLayoutConstraint.Axis.vertical
        
        //bulbStack koji je dio funFactstack-a
        bulbStackView.alignment = UIStackView.Alignment.leading
        bulbStackView.spacing   = 5
        bulbStackView.axis = NSLayoutConstraint.Axis.horizontal
        
        //elementi bulbStack-a
        bulbImage = UIImage(named: "Bulb")!
        bulbImageView.image = bulbImage
        funFactLabel.text = "Fun fact"
        funFactLabel.font = UIFont(name: "Futura", size: 25)
        
        
        //dodaj elemente u bulbStackView
        //        if firstLoad < 2{
        bulbStackView.addArrangedSubview(bulbImageView)
        bulbStackView.addArrangedSubview(funFactLabel)
        
        //drugi element funfactStacka
        funFactDescription.numberOfLines = 0
        
        //dodaj elemente u glavni stack; funFactStack
        funFactStack.addArrangedSubview(bulbStackView)
        funFactStack.addArrangedSubview(funFactDescription)
        
        funFactStack.isHidden = true
        
        
        
        tableView.backgroundColor = .purple
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "QuizzCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.rowHeight = 180
        tableView.bounces = true
        
        tableView.isHidden = true
        
        
    }
    
    @objc func getQuizzPressed(){
        
        if internetConnection == true{
            quizzesViewPresenter.fetchQuizes()
        }
        

    }
    
    func fetchSuccessful(quizzes: [Quiz]){
        
        self.populateMatrix(quiz: quizzes)
        firstLoad = true
        tableView.reloadData()
        funFactDescription.text = String(format: "%@ %d %@", "There are", quizzArray.flatMap{$0.questions}.filter{$0.question.contains("NBA")}.count, "questions that contain the word NBA")
        
        //        errorStack.removeFromSuperview()
        errorStack.isHidden = true
        funFactStack.isHidden = false
        tableView.isHidden = false
        
        for j in 0..<uniqueSectionArray.count{
            
            let  col = UIColor()
            colorOfCategory.append(col)
            colorOfCategory[j] = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
        }
        
    }
    
    
    //popuni 2-d tablicu quiz-ovima dohvaćenim s API-a putem QuizzesViewPresenter
    func populateMatrix(quiz: [Quiz]){
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


extension QuizzesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //prikazi kviz
        router.showQuiz(quiz: matrix[indexPath.section][indexPath.row])
        
    }
}



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
