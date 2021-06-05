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
        // Sets background to a blank/empty image
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
        UINavigationBar.appearance().backgroundColor = .clear
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = .white
        
        
        let vc = LoginViewController(router: self)
        navigationController.pushViewController(vc, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
    }
    
    //login button pritisnut i podatci za prijavu ispravni
    func showHomeScreen(){
        
        
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
    
    //logout button pritisnut i odjava uspješna
    func showLogin(){
        let lvc = LoginViewController(router: self)
        navigationController.setViewControllers([lvc], animated: false)
        
    }
    
    //MARK:- todo pageviewcontroller
    func showQuiz(quiz: Quiz){
        let questionPopUpVC = QuizViewController(router: self)
        questionPopUpVC.set(quiz: quiz)
        questionPopUpVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(questionPopUpVC, animated: false)
        
    }
    
    //prikaz rezultata kviza nakon odgovora na sva pitanja
    func presentScore(numCorrect: Int, numTotal: Int){
        let resultVC = QuizResultViewController(router: self)
        resultVC.modalPresentationStyle = .fullScreen
        resultVC.set(numOfCorrect: numCorrect, numOfQuestions: numTotal)
        navigationController.pushViewController(resultVC, animated: false)
    }
    
    //pritsnut gumb kojim se završava kviz
    func popToRoot(){
        navigationController.popToRootViewController(animated: false)
    }
    
    //presentanje ljestvice
    func showLeaderboard(){
        let lbdVC = LeaderboardViewController(router: self)
        lbdVC.modalPresentationStyle = .fullScreen
        navigationController.present(lbdVC, animated: false, completion: nil)
    }
    
    //dissmisanje ljestvice
    func dissmisLeaderBoard(){
        navigationController.presentedViewController?.dismiss(animated: false, completion: nil)
    }
}
