//
//  RegistrarVC.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/22/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit
import Firebase

class RegistrarVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //Variables
    var genero: String?
    var diabetes: String?
    var docRef: DocumentReference? = nil
    
    
    //Outlets
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pw1TextField: UITextField!
    @IBOutlet weak var pw2TextFiled: UITextField!
    @IBOutlet weak var generoPicker: UIPickerView!
    @IBOutlet weak var diabetesPicker: UIPickerView!
    @IBOutlet weak var nacimientoPicker: UIDatePicker!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        setUpSWReveal()
    }
    
//Funciones auxiliares
    func setUpSWReveal(){
        menuBtn.target = self.revealViewController()
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    func validateEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    
    @IBAction func registrarPressed(_ sender: UIButton) {

        var docId: String!
        let user = Auth.auth().currentUser
        if let user = user {
            docId = user.email
        }
        
        guard let name = nameTextField.text, !name.isEmpty else {return}
        guard let email = emailTextField.text?.lowercased(), !email.isEmpty else {return}
        guard let password = pw1TextField.text, !password.isEmpty else {return}
        guard let password2 = pw2TextFiled.text, !password2.isEmpty else {return}
        if genero == nil {genero = DataService.instance.getGenero()[0]}
        if diabetes == nil {diabetes = DataService.instance.getDiabetes()[0]}
        
        let dataToSave: [String: Any] = ["nombre": name, "genero": genero!, "nacimiento": nacimientoPicker.date, "diabetes": diabetes!, "doctor": docId ,"email": email]
        let userType: [String: Any] = ["tipo":"paciente"]

        if password == password2{
            if validateEmail(email: email){
                spinner.isHidden = false
                spinner.startAnimating()
                view.isUserInteractionEnabled = false
                if let secondaryApp = FirebaseApp.app(name: "CreatingUsersApp") {
                    let secondaryAppAuth = Auth.auth(app: secondaryApp)
                    
                    // Create user in secondary app.
                    secondaryAppAuth.createUser(withEmail: email, password: password) { (user, error) in
                        if error != nil {
                            let callBack = AuthService.instance.errorHandler(error: error! as NSError)
                            
                            switch callBack {
                                
                            case "usedEmail":
                                self.spinner.stopAnimating()
                                self.spinner.isHidden = true
                                self.view.isUserInteractionEnabled = true
                                print("email en uso")
                                let alert = UIAlertController(title: "Correo en uso", message: "Prueba crear una cuenta con otro correo",preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                self.present(alert, animated: true, completion: nil)
                                break
                                
                            case "userNotExists":
                                print("no existe")
                                self.spinner.stopAnimating()
                                self.spinner.isHidden = true
                                self.view.isUserInteractionEnabled = true
                                let alert = UIAlertController(title: "El usuario no existe", message: "Para acceder cree una cuenta",preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                self.present(alert, animated: true, completion: nil)
                                break
                                
                            case "wrongPW":
                                print("pw mala")
                                self.spinner.stopAnimating()
                                self.spinner.isHidden = true
                                self.view.isUserInteractionEnabled = true
                                let alert = UIAlertController(title: "Contrasenia incorrecta", message: "Ingresa otra vez la contrasenia",preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                self.present(alert, animated: true, completion: nil)
                                break
                                
                            case "weakPW":
                                print("pw fea")
                                self.spinner.stopAnimating()
                                self.spinner.isHidden = true
                                self.view.isUserInteractionEnabled = true
                                let alert = UIAlertController(title: "Contrasenia muy débil", message: "Prueba creando otra contrasenia",preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                self.present(alert, animated: true, completion: nil)
                                break
                                
                            default :
                                print("error")
                                self.spinner.stopAnimating()
                                self.spinner.isHidden = true
                                self.view.isUserInteractionEnabled = true
                                let alert = UIAlertController(title: "Error", message: "Ocurrió un errror, intentelo más tarde",preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                self.present(alert, animated: true, completion: nil)
                                break
                            }
                        }else {// fin de error != nil se insertan datos del paciente
                          
                            try! secondaryAppAuth.signOut()
                            self.docRef = Firestore.firestore().document("paciente/\(email)")
                            self.docRef?.setData(dataToSave) { (error) in
                                
                                if error != nil{
                                    
                                    self.spinner.stopAnimating()
                                    self.spinner.isHidden = true
                                    self.view.isUserInteractionEnabled = true
                                    let alert = UIAlertController(title: "Error", message: "Ocurrió un error, intenéntelo más tarde",preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                    self.present(alert, animated: true, completion: nil)
                                    //
                                }else{
                                    self.docRef = Firestore.firestore().document("user/\(email)")
                                    self.docRef?.setData(userType) { (error) in
                                        if error != nil{
                                            self.spinner.stopAnimating()
                                            self.spinner.isHidden = true
                                            self.view.isUserInteractionEnabled = true
                                            let alert = UIAlertController(title: "Error", message: "Ocurrió un error, intenéntelo más tarde",preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                            self.present(alert, animated: true, completion: nil)
                                        }else{
                                            DataService.instance.getPaccientesFromFB()
                                            print("bien tipo")
                                            self.spinner.stopAnimating()
                                            self.spinner.isHidden = true
                                            self.view.isUserInteractionEnabled = true
                                            let alert = UIAlertController(title: "Bien", message: "Usuario creado",preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                            self.present(alert, animated: true, completion: nil)
                                            ///
                                            self.emailTextField.text = nil
                                            self.nameTextField.text = nil
                                            self.pw1TextField.text = nil
                                            self.pw2TextFiled.text = nil
                                            self.generoPicker.selectRow(0, inComponent: 0, animated: true)
                                            self.diabetesPicker.selectRow(0, inComponent: 0, animated: true)
                                           // self.nacimientoPicker.setDate(Date., animated: true)
                                        }
                                    }
                                }//
                            }
                        }
                    }
                }
            }else{//if else email
                let alert = UIAlertController(title: "Error", message: "Por favor introduzca un e-mail válido",preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }else{//if pw
            let alert = UIAlertController(title: "Error", message: "Las contrasenias no son iguales",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true, completion: nil)
        }//else ps
    }//

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == diabetesPicker{
            return DataService.instance.getDiabetes().count
        }
        if pickerView == generoPicker {
            return DataService.instance.getGenero().count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == diabetesPicker{
            return DataService.instance.getDiabetes()[row]
        }
        if pickerView == generoPicker {
            return DataService.instance.getGenero()[row]
        }
        return ""
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == diabetesPicker{//detalle aquí
            diabetes = DataService.instance.getDiabetes()[row]
        }
        if pickerView == generoPicker {
            genero = DataService.instance.getGenero()[row]
        }
    }
    
    
    
}//
