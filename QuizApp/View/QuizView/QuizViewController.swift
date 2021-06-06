//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 06.05.2021..
//

import UIKit

class QuizViewController: UIViewController, UIGestureRecognizerDelegate {

    //timer
    var timerLabel = UILabel()
    var timer:Timer?
    var miliseconds:Int = 0
    
    //progressBar i broj pitanja
    var questionNum = UILabel()
    let progressStackView = UIStackView()
    var viewArray = [UIView]()
    
    //pomocne varijable za osvjezavanje progress bara
    var numberOfQuestions = 0
    var numOfCorrectAnswers = 0
    var currentQuestion = 0
    
    let defaults = UserDefaults()
    var quizId = 0
    
    
   
    private let quizViewPresenter = QuizViewPresenter(networking: NetworkService())
    
   let childPageController = QuizUIPageController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    
    private var router: AppRouter!
    convenience init(router: AppRouter){
        self.init()
        self.router = router
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizViewPresenter.setQuizViewDelegate(quizViewDelegate: self)
        childPageController.setViewDelegate(viewDelegate: self)
        
        //UI
        buildViews()
        createProgressBar()
        configureLeftBarItemButton()

        //timer
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    //popunjava podatke potrebne za prikaz pitanja odabirom odredenog kviza
    func set(quiz: Quiz){
        childPageController.set(quiz: quiz)
        numberOfQuestions = quiz.questions.count
        quizId = quiz.id
        UserDefaults.standard.setValue(quizId, forKey: "quizID")
    }
    
    
    //početno stvaranje dinamičkog broja viewova jednake širine gdje svaki predstavlja jedno pitanje
    //spremanje tih view-ova u viewArray za kasnije baratanje s njihovim bojama
    func createProgressBar(){
        let razlomak = 1.0/Float(numberOfQuestions)
        for _ in 1...numberOfQuestions{
            let view = UIView()
            view.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
            view.layer.cornerRadius = 10
            viewArray.append(view)
            progressStackView.addArrangedSubview(view)
            view.widthAnchor.constraint(equalTo: progressStackView.widthAnchor, multiplier: CGFloat(razlomak)).isActive = true
        }
        //initial white
        viewArray[0].backgroundColor = .white
    }
    
 
    
    func updateProgressBar(answer : Bool){
        //update rednog broj pitanja iznad progress bar-a
        questionNum.text = "\(currentQuestion+2)/\(numberOfQuestions)"
        //update progress bar-a na osnovi točnosti odabranog odgovora
        if answer == true{
            viewArray[currentQuestion].backgroundColor = .green
            numOfCorrectAnswers += 1
        }else{
            viewArray[currentQuestion].backgroundColor = .red
        }
        if currentQuestion < viewArray.count-1{
            currentQuestion += 1
        }
        viewArray[currentQuestion].backgroundColor = .white
    }
    
    
    func quizFinished(){
        //nema više pitanja, prenesi i prikaži rezultat na QuizResultViewControlleru
        timer?.invalidate()
        quizViewPresenter.postResult(quizID: quizId, userID: defaults.integer(forKey: "id"), time: Double(miliseconds)/100.0, numOfCorrect: numOfCorrectAnswers, token: defaults.string(forKey: "token")!)
        router.presentScore(numCorrect: numOfCorrectAnswers, numTotal: numberOfQuestions)
    }
    
    //brojac milisekundi
    @objc func timerFired() {
        miliseconds += 1
        let seconds:Double = Double(miliseconds)/100
        timerLabel.text = String(format: "Time: %.1f", seconds)
    }
    
    //custom leftBarItemButton
    func  configureLeftBarItemButton(){
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .done, target: self, action: #selector(backButtonPressed))
        
    }
    
    //Back Bar Button funkcije
    @objc func backButtonPressed(){
        navigationController?.popViewController(animated: false)
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
