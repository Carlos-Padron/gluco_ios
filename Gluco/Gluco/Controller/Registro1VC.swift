//
//  Registro1VC.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/28/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit
import Firebase
class Registro1VC: UIViewController {
    
    //Variables
    var name: String?
    
    
    //Outlets
    
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var password2TextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        spinner.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    
    //Funciones auxiliares
    func validateEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    
    @IBAction func registrarPressed(_ sender: Any) {
        
        guard let nombre = nombreTextField.text, nombreTextField.text != "" else {return}
        guard let email = emailTextField.text?.lowercased(), emailTextField.text?.lowercased() != "" else {return}
        guard let password = passwordTextField.text , passwordTextField.text != "" else {return}
        guard let password2 = password2TextField.text, password2TextField.text != "" else {return}
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        if password == password2 {
            print("Entr[o a password")
            if validateEmail(email: email){
                print("entró a funcion")
                Auth.auth().createUser(withEmail: email, password: password) { (AuthDataResult, error) in
                    if error != nil {
                        
                     let callBack = AuthService.instance.errorHandler(error: error! as NSError)

                            switch callBack {
                                
                            case "usedEmail":
                                self.spinner.stopAnimating()
                                self.spinner.isHidden = true
                                print("email en uso")
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
                                let alert = UIAlertController(title: "Error", message: "Ocurrió un errror, intentelo más tarde",preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                self.present(alert, animated: true, completion: nil)
                                break
                            }
                    }else{
                        self.spinner.stopAnimating()
                        self.spinner.isHidden = true
                        variables.userType = "doctor"
                        self.name = nombre
                    self.performSegue(withIdentifier: "CompletarRegistroSegue", sender: nombre)
                       
                    }
                }
            }else{
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                let alert = UIAlertController(title: "Error", message: "Por favor introduzca un E/mail válido",preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
            let alert = UIAlertController(title: "Error", message: "Las contrasenias no son iguales",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }//
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CompletarRegistroSegue"{
            guard let destVC = segue.destination as? CompletarRegistroVC else{return}
            destVC.name = name
        }
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
