//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 06.05.2021..
//

import UIKit

class QuizViewController: UIViewController {

    //progressBar i broj pitanja
    var questionNum = UILabel()
    let progressStackView = UIStackView()
    var viewArray = [UIView]()
    
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
    
    private var router: AppRouter!
    convenience init(router: AppRouter){
        self.init()
        self.router = router
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .purple
       
        
        setConstraints()
        createProgressBar()
        addTargetsForAnswers()
        anyAnswerPressed()
           
        //MARK:-zašto ovo ne radi?
        navigationItem.backBarButtonItem?.title = ""
        navigationItem.backBarButtonItem?.image = UIImage(named: "backButton")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    //popunjava podatke potrebne za prikaz pitanja odabirom odredenog kviza
    func set(quiz: Quiz){
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
    
        //questionNum
        self.view.addSubview(questionNum)
        questionNum.translatesAutoresizingMaskIntoConstraints = false
        questionNum.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1).isActive = true
        questionNum.heightAnchor.constraint(equalToConstant: 20).isActive = true
        questionNum.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        questionNum.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        
        //progressStackView
        self.view.addSubview(progressStackView)
        progressStackView.translatesAutoresizingMaskIntoConstraints = false
        answerStackView.distribution  = UIStackView.Distribution.fillEqually
        answerStackView.alignment = UIStackView.Alignment.center
        answerStackView.spacing   = 30.0
        answerStackView.axis = NSLayoutConstraint.Axis.horizontal
        
        progressStackView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        progressStackView.topAnchor.constraint(equalTo: questionNum.bottomAnchor, constant: 10).isActive = true
        progressStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        progressStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        
        //question
        self.view.addSubview(question)
        question.translatesAutoresizingMaskIntoConstraints = false
        question.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 30).isActive = true
        question.topAnchor.constraint(equalTo: progressStackView.bottomAnchor ,constant: 40).isActive = true
        question.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -40).isActive = true
        question.numberOfLines = 0
        question.font = UIFont.boldSystemFont(ofSize: 25)
      

        //answerStackView
        self.view.addSubview(answerStackView)
        answerStackView.distribution  = UIStackView.Distribution.fillEqually
        answerStackView.alignment = UIStackView.Alignment.center
        answerStackView.spacing   = 20.0
        answerStackView.axis = NSLayoutConstraint.Axis.vertical
        
        answerStackView.translatesAutoresizingMaskIntoConstraints = false
        answerStackView.topAnchor.constraint(equalTo: question.bottomAnchor, constant: 40).isActive = true
        answerStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        answerStackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4).isActive = true
        answerStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -30).isActive = true
        answerStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 30).isActive = true
        
       
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

