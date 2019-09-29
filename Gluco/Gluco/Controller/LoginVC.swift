//
//  LoginVC.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/26/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isUserInteractionEnabled = false
        navigationController?.navigationBar.tintColor = UIColor.clear

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registrarPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "RegistroSegue", sender: self)
    }

    
}
