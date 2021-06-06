//
//  SearchViewController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 01.06.2021..
//

import UIKit


class SearchViewController: UIViewController, SearchViewProtocol{
    
    //search stack
    var searchStack = UIStackView()
    var inputTextField = UITextField()
    var searchButton = UIButton()
    
    var tableView = UITableView()
    
    //array kvizova
    var quizzArray :[Quiz] = []
    
    //array kategorija
    var uniqueSectionArray = [QuizCategory]()
    
    //2-d matrica popunjena s kvizovima sortiranim prema kategorijama
    var matrix = [[Quiz]]()
    var colorOfCategory =  [UIColor]()
    
    var firstLoad = false

    
    let nService = NetworkService()
    private let searchViewPresenter = SearchViewPresenter(networking: NetworkService())

    private var router: AppRouter!
    convenience init(router: AppRouter) {
        self.init()
        self.router = router
      
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewPresenter.setSearchViewDelegate(searchViewDelegate: self)
        
        //UI
       buildViews()
        
        //skrivanje tipkovnice i odznačivanje textfieldova
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(uiViewPressed))
        view.addGestureRecognizer(tap)
        
        //funkcionalnost
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        inputTextField.addTarget(self, action: #selector(didTapEmailTextField), for: .editingDidBegin)
    }
    
    
    
    
    
    
    @objc func searchButtonPressed(){
        matrix.removeAll()
       
        inputTextField.layer.borderWidth = 0
        tableView.isHidden = true
        
        searchViewPresenter.fetchQuizzesFromCD(with: inputTextField.text! )
        tableView.reloadData()
    }
    
    @objc private func didTapEmailTextField(){
        inputTextField.layer.borderWidth = 1
        inputTextField.layer.borderColor = UIColor.white.cgColor
       
    }
    //odznači inputTextField
    @objc private func uiViewPressed(){
        view.endEditing(true)
        inputTextField.layer.borderWidth = 0
       
    }
    
    func fetchSuccessful(matrix: [[Quiz]], uniqueSectionArray: [QuizCategory], quizzArray: [Quiz]){
        
        self.matrix = matrix
        self.uniqueSectionArray = uniqueSectionArray
        self.quizzArray = quizzArray
        firstLoad = true

        tableView.reloadData()
        tableView.isHidden = false
        
        for j in 0..<uniqueSectionArray.count{
            
            let col = UIColor()
            colorOfCategory.append(col)
            colorOfCategory[j] = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
        }
        
    }
    
}





extension SearchViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //prikazi kviz
        router.showQuiz(quiz: matrix[indexPath.section][indexPath.row])
        
    }
}








extension SearchViewController: UITableViewDataSource{
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
