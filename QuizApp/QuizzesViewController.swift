//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 14.04.2021..
//

import UIKit

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
    var quizzesLoaded: Bool = false
    
    //fun fact stack
    let funFactStack : UIStackView = UIStackView()
    let bulbStackView : UIStackView = UIStackView()
    var bulbImage : UIImage = UIImage()
    let funFactLabel : UILabel = UILabel()
    let funFactDescription: UILabel = UILabel()
    
    var tableView = UITableView()
    
    //array kvizova
    var quizzArray :[Quiz] = []
    let dService = DataService()
    
    //array kategorija
    var uniqueSectionArray = [QuizCategory]()
    //2-d matrica popunjena s kvizovima sortiranim prema kategorijama
    var matrix = [[Quiz]]()
    var colorOfCategory =  [UIColor]()
    
    var questionPopUpVC = PopUp()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        
        //add Subviews
        view.addSubview(quizNameLabel)
        view.addSubview(getQuizzButton)
        view.addSubview(errorStack)
        
        //constraints and atributes of main screen
        loadElements()
        populateMatrix()
        //funkcionalnost
        getQuizzButton.addTarget(self, action: #selector(getQuizzPressed), for: .touchUpInside)
        
        
        
    }
    
    func loadElements(){
        
        //quizName
        quizNameLabel.translatesAutoresizingMaskIntoConstraints = false
        quizNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        quizNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant :20 ).isActive = true
        quizNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        quizNameLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        quizNameLabel.text = "PopQuiz"
        quizNameLabel.font = UIFont(name: "Futura", size: 30)
        quizNameLabel.textAlignment = NSTextAlignment.center
        
        //quizButton
        getQuizzButton.translatesAutoresizingMaskIntoConstraints = false
        getQuizzButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        getQuizzButton.topAnchor.constraint(equalTo: quizNameLabel.bottomAnchor, constant :0 ).isActive = true
        getQuizzButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        getQuizzButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        getQuizzButton.setTitle("Get Quizz", for: .normal)
        getQuizzButton.backgroundColor = UIColor(white: 1, alpha: 1)
        getQuizzButton.setTitleColor(.purple, for: .normal)
        getQuizzButton.layer.cornerRadius = 20
        
        
        
        //
        errorImageView.image = UIImage(named: "error")
//        errorImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        errorImageView.contentMode = .scaleAspectFit
        errorTitle.text = "Error\n"
        errorTitle.font = UIFont.boldSystemFont(ofSize: 27)
        errorDescription1.text = "Data can't be reached."
        errorDescription2.text = "Please try again"
        
        
        
        
        //error stack
        errorStack.translatesAutoresizingMaskIntoConstraints = false
        errorStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        errorStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        
        
        errorStack.distribution  = UIStackView.Distribution.fillProportionally
        errorStack.alignment = UIStackView.Alignment.center
        errorStack.spacing   = 0.0
        errorStack.axis = NSLayoutConstraint.Axis.vertical
        

        
        errorStack.addArrangedSubview(errorImageView)
        errorStack.addArrangedSubview(errorTitle)
        errorStack.addArrangedSubview(errorDescription1)
        errorStack.addArrangedSubview(errorDescription2)
        
        
        
    }
    
    @objc func getQuizzPressed(){
        
        errorStack.removeFromSuperview()
        if(!quizzesLoaded){
            loadQuizzes()
        }
        quizzesLoaded = true
        
        
    }
    
    //popuni 2-d tablicu quiz-ovima soriranim prema kategorijama pruženim u DataService-u
    func populateMatrix(){
        quizzArray = dService.fetchQuizes()
        let sections = quizzArray.flatMap{$0.category}
        uniqueSectionArray = Array(Set(sections))
        let length = uniqueSectionArray.count
        //iteriraj po svakoj kategoriji
        for j in 0..<length{
            let group = [Quiz]()
            matrix.append(group)
            let currentSection = uniqueSectionArray[j]
            //iteriraj po svim kvizovima i dodaj ih u stupac matrice za konkretnu kategoriju
            for i in 0..<quizzArray.count{
                if (quizzArray[i].category == currentSection){
                    matrix[j].append(quizzArray[i])
                }
            }}
        
        
    }
    func loadQuizzes(){
        
        //fun fact stack
        view.addSubview(funFactStack)
        funFactStack.translatesAutoresizingMaskIntoConstraints = false
        funFactStack.distribution  = UIStackView.Distribution.equalSpacing
        funFactStack.alignment = UIStackView.Alignment.leading
        funFactStack.spacing   = 20.0
        funFactStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        funFactStack.axis = NSLayoutConstraint.Axis.vertical
        funFactStack.topAnchor.constraint(equalTo: getQuizzButton.bottomAnchor, constant: 40).isActive = true
        
        
        
        let bulbImageView = UIImageView()
        bulbImage = UIImage(named: "bulb.png")!
        let imageViewWidthConstraint = NSLayoutConstraint(item: bulbImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        let imageViewHeightConstraint = NSLayoutConstraint(item: bulbImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        bulbImageView.addConstraints([imageViewWidthConstraint, imageViewHeightConstraint])
        bulbImageView.image = bulbImage
        
        funFactLabel.text = "Fun fact"
        funFactLabel.font = UIFont(name: "Futura", size: 25)
        
        
        bulbStackView.alignment = UIStackView.Alignment.leading
        bulbStackView.spacing   = 5
        bulbStackView.axis = NSLayoutConstraint.Axis.horizontal
        
        bulbStackView.addArrangedSubview(bulbImageView)
        bulbStackView.addArrangedSubview(funFactLabel)
        
        funFactDescription.text = String(format: "%@ %d %@", "There are", quizzArray.flatMap{$0.questions}.filter{$0.question.contains("NBA")}.count, "questions that contain the word NBA")
        funFactDescription.numberOfLines = 0
        
        funFactStack.addArrangedSubview(bulbStackView)
        funFactStack.addArrangedSubview(funFactDescription)
        
        
        for j in 0..<uniqueSectionArray.count{

           let  col = UIColor()
            colorOfCategory.append(col)
            colorOfCategory[j] = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
        }
        
        //tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView = UITableView(frame: CGRect(x: 0, y: 330, width: view.bounds.width, height: view.bounds.height))
        tableView.backgroundColor = .purple
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "QuizzCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.rowHeight = 180
        tableView.backgroundColor = .purple
        tableView.bounces = true
        
 
    }
}
extension QuizzesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        view.addSubview(questionPopUpVC)
        questionPopUpVC.set(quiz: matrix[indexPath.row][indexPath.section], category: uniqueSectionArray[indexPath.section], quizzId:matrix[indexPath.row][indexPath.section].id
        )
    }
}






extension QuizzesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        label.text = "      \(uniqueSectionArray[section].rawValue)"
        label.backgroundColor = .purple
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
