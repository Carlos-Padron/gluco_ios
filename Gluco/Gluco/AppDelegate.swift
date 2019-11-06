//
//  AppDelegate.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/12/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
         class AppDelegate: UIResponder, UIApplicationDelegate, SWRevealViewControllerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        self.getPacientes()
        //self.getInfo()
        self.setInitialViewController()
        FirebaseApp.configure(name: "CreatingUsersApp", options: FirebaseApp.app()!.options)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    
    func setInitialViewController() {
        var docRef: DocumentReference!
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil{
                let userId = user?.email
                docRef = Firestore.firestore().document("user/\(userId!)")
                docRef.getDocument(completion: { (docSnapshot, error) in
                    guard let docSnapshot = docSnapshot, docSnapshot.exists else {return}
                    
                    let data = docSnapshot.data()
                    variables.userType = data!["tipo"] as? String ?? ""
                    print("tipo de usuario " + variables.userType)
                    if variables.userType == "paciente" {
                        let frontNavigationController:UINavigationController
                        let revealController = SWRevealViewController()
                        var mainRevealController = SWRevealViewController()
                        
                        let front = storyboard.instantiateViewController(withIdentifier:  "MedicionViewContoller") as! MedicionVC
                        let rear = storyboard.instantiateViewController(withIdentifier: "MenuController") as! MenuVC
                        
                        frontNavigationController =  UINavigationController.init(rootViewController: front)
                        frontNavigationController.navigationBar.barTintColor = UIColor.init(red: 12.0/255.0, green: 73.0/255.0, blue: 120.0/255.0 , alpha: 1.0)
                        frontNavigationController.navigationBar.titleTextAttributes = [
                            NSAttributedString.Key.foregroundColor : UIColor.white,
                            NSAttributedString.Key.font : UIFont(name: "Avenir-Heavy", size: 45)!
                        ]
                        frontNavigationController.navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
                        revealController.frontViewController = frontNavigationController
                        revealController.rearViewController = rear
                        revealController.delegate = self
                        mainRevealController  = revealController
                        
                        UIApplication.shared.delegate!.window??.rootViewController = mainRevealController
                        //
                    }
                    else {
                        let frontNavigationController:UINavigationController
                        let revealController = SWRevealViewController()
                        var mainRevealController = SWRevealViewController()
                        
                        let front = storyboard.instantiateViewController(withIdentifier:  "ConsultaController") as! ConsultaVC
                        let rear = storyboard.instantiateViewController(withIdentifier: "MenuController") as! MenuVC
                        
                        frontNavigationController =  UINavigationController.init(rootViewController: front)
                        frontNavigationController.navigationBar.barTintColor = UIColor.init(red: 12.0/255.0, green: 73.0/255.0, blue: 120.0/255.0 , alpha: 1.0)
                        frontNavigationController.navigationBar.titleTextAttributes = [
                            NSAttributedString.Key.foregroundColor : UIColor.white,
                            NSAttributedString.Key.font : UIFont(name: "Avenir-Heavy", size: 45)!
                        ]
                        frontNavigationController.navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
                        revealController.frontViewController = frontNavigationController
                        revealController.rearViewController = rear
                        revealController.delegate = self
                        mainRevealController  = revealController
                        
                        UIApplication.shared.delegate!.window??.rootViewController = mainRevealController
                        
                        DataService.instance.fecthInfoFromFB(email: userId!)
                    }
                })
            }else{
                let login = storyboard.instantiateViewController(withIdentifier: "LogInController")
                self.window?.rootViewController = login
                self.window?.makeKeyAndVisible()
            }
            
        }
    }

    func getPacientes(){
        if Auth.auth().currentUser != nil {
            DataService.instance.getPaccientesFromFB()
            
        }
    }
    
    func getInfo(){
         if Auth.auth().currentUser != nil {
            let email = Auth.auth().currentUser?.email
        DataService.instance.fecthInfoFromFB(email: email!)
        }
    }
    
}
