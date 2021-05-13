//
//  AppRouter.swift
//  QuizApp
//
//  Created by Antonio Markotic on 07.05.2021..
//
import UIKit
class AppRouter: AppRouterProtocol{
    
    
    private let navigationController: UINavigationController!
 
       init(navigationController: UINavigationController) {
           self.navigationController = navigationController
       }

    
    
    func setStartScreen(in window: UIWindow?) {
        let vc = LoginViewController(router: self)
        navigationController.pushViewController(vc, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

    }
    
    
    //showHomeScreen bolje nazivlje
    func loginButtonPressedAndSuccesfull(){
        
        
        let qvc = QuizzesViewController(router: self)
        let navQvc = UINavigationController(rootViewController: qvc)
        let svc = SettingsViewController(router: self)
        
        //tabbar[QuizzesViewControler, SettingsViewController]
        let tabbar = UITabBarController()
        tabbar.viewControllers = [navQvc, svc]
        
        //izgled tabBar-a
        navQvc.tabBarItem.image = UIImage(named: "Quizz")
        navQvc.tabBarItem.title = "Quiz"
        svc.tabBarItem.image = UIImage(named: "Settings")
        svc.tabBarItem.title = "Settings"
        tabbar.tabBar.barTintColor = .white
        tabbar.tabBar.tintColor = .purple
        
        
        navigationController.setViewControllers([tabbar], animated: true)

    }
    
    func logOutButtonPressed(){
        let lvc = LoginViewController(router: self)
        navigationController.setViewControllers([lvc], animated: false)
       
    }
    
    //pageviewcontroller je bolje rjesenje nego updejtat uiview
    func showQuiz(quiz: Quiz){
        let questionPopUpVC = QuizViewController(router: self)
        questionPopUpVC.set(quiz: quiz)
        
        questionPopUpVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(questionPopUpVC, animated: false)

    }
    func presentScore(numCorrect: Int, numTotal: Int){
        let resultVC = QuizResultViewController(router: self)
        resultVC.modalPresentationStyle = .fullScreen
        resultVC.set(numOfCorrect: numCorrect, numOfQuestions: numTotal)
        navigationController.pushViewController(resultVC, animated: false)
    }
    
    func popToRoot(){
        navigationController.popToRootViewController(animated: false)
    }
}
