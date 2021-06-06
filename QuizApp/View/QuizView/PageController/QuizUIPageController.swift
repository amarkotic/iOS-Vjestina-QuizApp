//
//  QuizUIPageController.swift
//  QuizApp
//
//  Created by Antonio Markotic on 05.06.2021..
//

import UIKit


class QuizUIPageController: UIPageViewController, QuizUIPageControllerProtocol{
    
    var quiz : Quiz?
    var questionArray = [Question]()
    
    private var controllers: [UIViewController] = []
    var displayedIndex = 0
    
    weak private var viewDelegate: QuizViewController?
    func setViewDelegate(viewDelegate: QuizViewController){
        self.viewDelegate = viewDelegate
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateControllers()
        
        //postavljanje PageControllera
        guard let firstVC = controllers.first else { return }
        dataSource = self
        setViewControllers([firstVC], direction: .forward, animated: true,
                           completion: nil)
    }
    
    //PageControlleru šaljemo iz delegata(QuizViewController-a) kviz koji treba prikazati 
    func set(quiz: Quiz){
        self.quiz = quiz
        questionArray = quiz.questions
    }
    
    //kreiramo onoliko Page-ova koliko ima pitanja u kvizu
    func populateControllers(){
        for question in questionArray{
            let page = QuizUIPage(question: question)
            page.setPageDelegate(pageDelegate: self)
            controllers.append(page)
        }
    }
    
    //poziva se nakon odabranog odgovora na svakom od Page-ova dok još ima pitanja i šalje delegatu info o točnosti te zakljucno na kraju kviza javlja delegatu da je kviz gotov
    func checkIf(answer : Bool){
        viewDelegate!.updateProgressBar(answer: answer)
        if displayedIndex < questionArray.count-1{
            displayedIndex += 1
            goToNextPage()
        }else{
            viewDelegate?.quizFinished()
        }
    }
}






//UIPageView data source
extension QuizUIPageController: UIPageViewControllerDataSource {
    // Navigacija u nazad
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        
        return controllers[displayedIndex]
    }
    //Navigacija u naprijed
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        return controllers[displayedIndex]
    }
}



//custom funkcija koja prikazuje iduću stranicu
extension UIPageViewController {
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let currentViewController = viewControllers?[0] {
            if let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
                setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
            }
        }
    }
}
