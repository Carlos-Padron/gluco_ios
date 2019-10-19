//
//  LoginVC.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/26/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    //Outlets
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
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

    @IBAction func logInPressed(_ sender: UIButton) {

      performSegue(withIdentifier: "unwindConsultas", sender: self)
    }
    
    func validateEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
}
