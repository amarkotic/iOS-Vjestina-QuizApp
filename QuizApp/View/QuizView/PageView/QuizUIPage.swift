//
//  QuizUIPage.swift
//  QuizApp
//
//  Created by Antonio Markotic on 05.06.2021..
//

import UIKit
import SnapKit

class QuizUIPage: UIViewController{
    
    let question : Question?
    
    //pitanje i odgovori
    let questionLabel = UILabel()
    let answerStackView = UIStackView()
    let answerOne = UIButton()
    let answerTwo = UIButton()
    let answerThree = UIButton()
    let answerFour = UIButton()
    
    init(question: Question) {
        self.question = question
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak private var pageDelegate: QuizUIPageController?
    func setPageDelegate(pageDelegate: QuizUIPageController?){
        self.pageDelegate = pageDelegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        
        //funkcionalnost
        addTargetsForAnswers()
    }
    
    func addTargetsForAnswers(){
        answerOne.addTarget(self, action: #selector(answerOnePressed), for: .touchUpInside)
        answerTwo.addTarget(self, action: #selector(answerTwoPressed), for: .touchUpInside)
        answerThree.addTarget(self, action: #selector(answerThreePressed), for: .touchUpInside)
        answerFour.addTarget(self, action: #selector(answerFourPressed), for: .touchUpInside)
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
        let correctAnswer = question?.correctAnswer
        var isCorrect = false
        //zabrani stiskanje odgovora do idućeg pitanja
        answerOne.isEnabled = false
        answerTwo.isEnabled = false
        answerThree.isEnabled = false
        answerFour.isEnabled = false
        
        //odgovor je točan
        if correctAnswer == num {
            isCorrect = true
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
            
            //zazeleni točan odgovor nakon 0.5s
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                makeCorrectAnswerGreen(correct : correctAnswer!)
            }
            
        }
        
        //šalji delegatu(QuizUIPageController) podatke o točnosti odabranog odgovora
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            pageDelegate?.checkIf(answer: isCorrect)
        }
    }
    
    
    func makeCorrectAnswerGreen(correct : Int){
        switch correct   {
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
}
