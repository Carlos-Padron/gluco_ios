//
//  ConsultaVC.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/15/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit

class ConsultaVC: UIViewController {

    //IBOutlet

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSWReveal()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
            // isLogin()
    }
    
    
    func setUpSWReveal(){
        menuBtn.target = self.revealViewController()
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    func isLogin(){
        if (true){
             self.performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }

    
}
