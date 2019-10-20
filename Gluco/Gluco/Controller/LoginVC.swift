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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registrarPressed(_ sender: UIButton) {

       self.performSegue(withIdentifier: "RegistroSegue", sender: self)
    }

    @IBAction func logInPressed(_ sender: UIButton) {
        
        guard let email =  emailTextField.text, emailTextField.text != "" else {return}
        guard let password = passwordTextField.text, passwordTextField.text != "" else {return}
        
        spinner.isHidden = false
        spinner.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                
                let callBack = AuthService.instance.errorHandler(error: error! as NSError)
                
                switch callBack {
                case "usedEmail":
                    print("email en uso")
                    self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                    let alert = UIAlertController(title: "Correo en uso", message: "Prueba crear una cuenta con otro correo",preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true, completion: nil)
                    break
                    
                case "userNotExists":
                    print("no existe")
                     self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                    let alert = UIAlertController(title: "El usuario no existe", message: "Para acceder cree una cuenta",preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true, completion: nil)
                    break
                    
                case "wrongPW":
                    print("pw mala")
                     self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                    let alert = UIAlertController(title: "Contrasenia incorrecta", message: "Ingresa otra vez la contrasenia",preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true, completion: nil)
                    break
                    
                case "weakPW":
                    print("pw fea")
                     self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                    let alert = UIAlertController(title: "Contrasenia muy débil", message: "Prueba creando otra contrasenia",preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true, completion: nil)
                    break
                    
                default :
                    print("error")
                     self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                    let alert = UIAlertController(title: "Error", message: "Ocurrió un error, intentelo más tarde",preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true, completion: nil)
                    break
                }
            }else {
                let user = Auth.auth().currentUser
                if let user = user {
                   let userId = user.email
                    
                    
                    var docRef: DocumentReference!
                    docRef = Firestore.firestore().document("user/\(userId!)")
                    docRef.getDocument(completion: { (docSnapshot, error) in
                        guard let docSnapshot = docSnapshot, docSnapshot.exists else {return}
                        
                        let data = docSnapshot.data()
                        variables.userType = data!["tipo"] as? String ?? ""
                        self.spinner.stopAnimating()
                        self.spinner.isHidden = true
                        if variables.userType == "paciente" {
                            
                            self.performSegue(withIdentifier: "unwindMediciones", sender: self)
                        }
                        else if variables.userType == "doctor" {
                            self.performSegue(withIdentifier: "unwindConsultas", sender: self)
                        }
                    })
                }//
            }
        }
        
        

        
        
      //performSegue(withIdentifier: "unwindConsultas", sender: self)
    }
    
    func validateEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
}
