//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 06.05.2021..
//

import UIKit
import SnapKit
class QuizViewController: UIViewController, UIGestureRecognizerDelegate, QuizViewProtocol {
   
    
    //progressBar i broj pitanja
    var questionNum = UILabel()
    let progressStackView = UIStackView()
    var viewArray = [UIView]()
    
    
    //timer
    var timerLabel = UILabel()
    
    
    //pitanje i odgovori
    let question = UILabel()
    let answerStackView = UIStackView()
    let answerOne = UIButton()
    let answerTwo = UIButton()
    let answerThree = UIButton()
    let answerFour = UIButton()
    
    
    var numberOfQuestions = 0
    var numOfCorrectAnswers = 0
    var currentQuestion = 0
    
    var questionArray = [Question]()
    var quizId = 0

    var timer:Timer?
    var miliseconds:Int = 0
    
    let defaults = UserDefaults()
    
    private var router: AppRouter!
    convenience init(router: AppRouter){
        self.init()
        self.router = router
    }
    
    private let quizViewPresenter = QuizViewPresenter(networking: NetworkService())
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .purple
        
        quizViewPresenter.setQuizViewDelegate(quizViewDelegate: self)
        
        //UI
        setConstraints()
        loadElements()
        createProgressBar()
        configureLeftBarItemButton()
        
        //funkcionalnost
        addTargetsForAnswers()
        anyAnswerPressed()
        
        //timer
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    @objc func timerFired() {
        miliseconds += 1
        let seconds:Double = Double(miliseconds)/100
        timerLabel.text = String(format: "Time: %.1f", seconds)
    }
    
    
    func  configureLeftBarItemButton(){
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .done, target: self, action: #selector(backButtonPressed))
        
    }
    
    @objc func backButtonPressed(){
        navigationController?.popViewController(animated: false)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    //popunjava podatke potrebne za prikaz pitanja odabirom odredenog kviza
    func set(quiz: Quiz){
        quizId = quiz.id
        UserDefaults.standard.setValue(quizId, forKey: "quizID")
        numberOfQuestions = quiz.questions.count
        questionNum.text = "\(currentQuestion+1)/\(numberOfQuestions)"
        questionArray = quiz.questions
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
    }
    
    func addTargetsForAnswers(){
        answerOne.addTarget(self, action: #selector(answerOnePressed), for: .touchUpInside)
        answerTwo.addTarget(self, action: #selector(answerTwoPressed), for: .touchUpInside)
        answerThree.addTarget(self, action: #selector(answerThreePressed), for: .touchUpInside)
        answerFour.addTarget(self, action: #selector(answerFourPressed), for: .touchUpInside)
    }
    
    //osvježava QuizViewController nakon svakog pritiska na odgovor, odnosno prikaza novog pitanja
    func anyAnswerPressed(){
        answerOne.isEnabled = true
        answerTwo.isEnabled = true
        answerThree.isEnabled = true
        answerFour.isEnabled = true
        
        //osvježava broj pitanja na kojem smo i progressStack
        questionNum.text = "\(currentQuestion+1)/\(numberOfQuestions)"
        viewArray[currentQuestion].backgroundColor = UIColor.init(white: 1, alpha: 1)
        
        //osvježava pitanje
        question.text = questionArray[currentQuestion].question
        
        //osvježava buttone odgovora za svako pitanje
        answerOne.setTitle(questionArray[currentQuestion].answers[0], for: .normal)
        answerTwo.setTitle(questionArray[currentQuestion].answers[1], for: .normal)
        answerThree.setTitle(questionArray[currentQuestion].answers[2], for: .normal)
        answerFour.setTitle(questionArray[currentQuestion].answers[3], for: .normal)
        answerOne.backgroundColor? = UIColor(white: 1, alpha: 0.5)
        answerTwo.backgroundColor? = UIColor(white: 1, alpha: 0.5)
        answerThree.backgroundColor? = UIColor(white: 1, alpha: 0.5)
        answerFour.backgroundColor? = UIColor(white: 1, alpha: 0.5)
    }
    
    

    @objc func answerOnePressed(){
        checkAnswerPressed(num: 0)
    }

    @objc func answerTwoPressed(){
        checkAnswerPressed(num: 1)
    }

    @objc func answerThreePressed(){
        checkAnswerPressed(num: 2)
    }

    @objc func answerFourPressed(){
        checkAnswerPressed(num: 3)
    }

    //logika za provjeru je li odgovor točan
    func checkAnswerPressed(num:Int){

        //zabrani stiskanje odgovora do idućeg pitanja
        answerOne.isEnabled = false
        answerTwo.isEnabled = false
        answerThree.isEnabled = false
        answerFour.isEnabled = false

        //odgovor je točan
        if questionArray[currentQuestion].correctAnswer == num {
            switch num {
            case 0:
                answerOne.backgroundColor = .green
            case 1:
                answerTwo.backgroundColor = .green
            case 2:
                answerThree.backgroundColor = .green
            case 3:
                answerFour.backgroundColor = .green
            default:
                return
            }
            //progressBar u zeleno za točan odogovr
            viewArray[currentQuestion].backgroundColor = .green
            numOfCorrectAnswers += 1
        }
        else{
            //odgovor je netočan
            switch num {
            case 0:
                answerOne.backgroundColor = .red
            case 1:
                answerTwo.backgroundColor = .red
            case 2:
                answerThree.backgroundColor = .red
            case 3:
                answerFour.backgroundColor = .red
            default:
                return
            }
            //progressBar u crveno za netočan odogovr
            viewArray[currentQuestion].backgroundColor = .red

            //zazeleni točan odgovor nakon 0.5s
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                makeCorrectAnswerGreen()
            }

        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            //nakon kratke pauze osvježi QuizViewController dok ima pitanja
            if self.currentQuestion<self.numberOfQuestions-1{
                self.currentQuestion  += 1
                self.anyAnswerPressed()
                
            }else{
                //nema više pitanja, prenesi i prikaži rezultat na QuizResultViewControlleru
                timer?.invalidate()
                quizViewPresenter.postResult(quizID: quizId, userID: defaults.integer(forKey: "id"), time: Double(miliseconds)/100.0, numOfCorrect: numOfCorrectAnswers, token: defaults.string(forKey: "token")!)
                router.presentScore(numCorrect: numOfCorrectAnswers, numTotal: numberOfQuestions)
            }}
    }
    
    
    func makeCorrectAnswerGreen(){
        
        switch questionArray[currentQuestion].correctAnswer    {
        case 0:
            answerOne.backgroundColor = .green
        case 1:
            answerTwo.backgroundColor = .green
        case 2:
            answerThree.backgroundColor = .green
        case 3:
            answerFour.backgroundColor = .green
        default:
            return
        }
    }
    
    
    
    func setConstraints(){
        
        //timer
        self.view.addSubview(timerLabel)
        timerLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: view.frame.width / 3, height: 20))
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
        }
        
        
        //questionNum
        self.view.addSubview(questionNum)
        questionNum.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: view.frame.width * 0.1, height: 20))
            make.leading.equalTo(view).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        
        //progressStackView
        self.view.addSubview(progressStackView)
        progressStackView.snp.makeConstraints { (make) in
            make.top.equalTo(questionNum.snp.bottom).offset(10)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(10)
        }
        
        //question
        self.view.addSubview(question)
        question.snp.makeConstraints { (make) in
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-40)
            make.top.equalTo(progressStackView.snp.bottom).offset(40)
            
        }
        
        //answerStackView
        self.view.addSubview(answerStackView)
        answerStackView.snp.makeConstraints { (make) in
            make.height.equalTo(view.frame.height * 0.4)
            make.centerX.equalTo(view)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
            make.top.equalTo(question.snp.bottom).offset(40)
        }
    }
    
    
    func loadElements(){
        //timerlabel
        timerLabel.font = UIFont(name: "Futura", size: 20)
        timerLabel.textAlignment = .center
        //question
        question.numberOfLines = 0
        question.font = UIFont.boldSystemFont(ofSize: 25)
        
        //answerStackView
        answerStackView.distribution  = UIStackView.Distribution.fillEqually
        answerStackView.alignment = UIStackView.Alignment.center
        answerStackView.spacing   = 20.0
        answerStackView.axis = NSLayoutConstraint.Axis.vertical
        
        //answers
        answerOne.layer.cornerRadius = 40
        answerOne.clipsToBounds = true
        answerOne.backgroundColor = .white
        answerOne.backgroundColor? = UIColor(white: 1, alpha: 0.5)
        answerOne.setTitleColor(.white, for: .normal)
        
        answerTwo.layer.cornerRadius = 40
        answerTwo.clipsToBounds = true
        answerTwo.backgroundColor = .white
        answerTwo.backgroundColor? = UIColor(white: 1, alpha: 0.5)
        answerTwo.setTitleColor(.white, for: .normal)
        
        answerThree.layer.cornerRadius = 40
        answerThree.clipsToBounds = true
        answerThree.backgroundColor = .white
        answerThree.backgroundColor? = UIColor(white: 1, alpha: 0.5)
        answerThree.setTitleColor(.white, for: .normal)
        
        answerFour.layer.cornerRadius = 40
        answerFour.clipsToBounds = true
        answerFour.backgroundColor = .white
        answerFour.backgroundColor? = UIColor(white: 1, alpha: 0.5)
        answerFour.setTitleColor(.white, for: .normal)
        
        
        //dodaj odgovore u answerStackView i postavi im širinu jer se u suprotnom neće prikazati
        answerStackView.addArrangedSubview(answerOne)
        answerStackView.addArrangedSubview(answerTwo)
        answerStackView.addArrangedSubview(answerThree)
        answerStackView.addArrangedSubview(answerFour)
        
        answerOne.widthAnchor.constraint(equalTo: answerStackView.widthAnchor, multiplier: 0.85).isActive = true
        answerTwo.widthAnchor.constraint(equalTo: answerStackView.widthAnchor, multiplier: 0.85).isActive = true
        answerThree.widthAnchor.constraint(equalTo: answerStackView.widthAnchor, multiplier: 0.85).isActive = true
        answerFour.widthAnchor.constraint(equalTo: answerStackView.widthAnchor, multiplier: 0.85).isActive = true
        
    }
}

