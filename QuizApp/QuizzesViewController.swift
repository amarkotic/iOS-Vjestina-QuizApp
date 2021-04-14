//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 14.04.2021..
//

import UIKit

class QuizzesViewController: UIViewController {
    let cellIdentifier = "cellId"
    let quizNameLabel: UILabel = UILabel()
    let getQuizzButton = UIButton()
    
    let errorLabel: UILabel = UILabel()
    let errorDescription = "Data can't be reached"
    let errorDescripton2 = "Please try again"
    var quizzesLoaded: Bool = false
    
    let funFactLabel : UILabel = UILabel()
    let funFactDescription:UILabel = UILabel()
    var bulbImage : UIImage = UIImage()
    
    let bulbStackView : UIStackView = UIStackView()
    let funFactStack : UIStackView = UIStackView()
    
    var tableView = UITableView()
    
    var quizzArray = [Quiz]()
    let dService = DataService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        view.addSubview(quizNameLabel)
        view.addSubview(getQuizzButton)
        view.addSubview(errorLabel)
        loadElements()
        quizzArray = dService.fetchQuizes()
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
        
        //Stack 1
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.topAnchor.constraint(equalTo: getQuizzButton.bottomAnchor, constant :150 ).isActive = true
        errorLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        errorLabel.textAlignment = NSTextAlignment.center
        errorLabel.text = "Error"
        
    }

    @objc func getQuizzPressed(){
       
        errorLabel.removeFromSuperview()
        if(!quizzesLoaded){
        loadQuizzes()
        }
        quizzesLoaded = true
    }
    
    func loadQuizzes(){
        
        
        //Stack
        view.addSubview(funFactStack)
        funFactStack.translatesAutoresizingMaskIntoConstraints = false
        funFactStack.distribution  = UIStackView.Distribution.equalSpacing
        funFactStack.alignment = UIStackView.Alignment.leading
        funFactStack.spacing   = 20.0
        funFactLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
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
       
        funFactDescription.text = String(format: "%@ %d %@", "There are", quizzArray.flatMap{$0.questions}.filter{$0.question.contains("NBA")}.count, " questions that contain the word NBA")
        
        funFactStack.addArrangedSubview(bulbStackView)
        funFactStack.addArrangedSubview(funFactDescription)
        
        
        
        
        
        
        
        
        //tableView
        
        
        tableView = UITableView(frame: CGRect(x: 0, y: 330, width: view.bounds.width, height: view.bounds.height))
      
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
//
//        tableView.topAnchor.constraint(equalTo: funFactStack.bottomAnchor, constant: 40)
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
//        tableView.rowHeight = 50
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 150
        tableView.delegate = self
       tableView.dataSource = self
        
        
        
        
       
        
    
   

}
}
extension QuizzesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}






extension QuizzesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        
        
        cell.backgroundColor = .purple
        
        let uiView = UIView()
    
        cell.addSubview(uiView)
        var image : UIImage = UIImage(named: "football.jpg")!
        cell.imageView!.image = image
        cell.textLabel?.text = quizzArray[indexPath.row].category.rawValue

        
         
//        var cellConfig: UIListContentConfiguration = cell.defaultContentConfiguration()
//        cellConfig.text = "Row \(indexPath.row)"
//        cellConfig.textProperties.color = .white
//        cell.contentConfiguration = cellConfig
        return cell
        
      
    }
    
    
}
