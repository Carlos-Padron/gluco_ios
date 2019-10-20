//
//  CompletarRegistroVC.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/29/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit
import Firebase

class CompletarRegistroVC: UIViewController {

    //Variables
    
    var name: String?
    var docRef: DocumentReference? = nil
    
    //Outlets
    @IBOutlet weak var consultorioTextField: UITextView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var consultaInicio: UIDatePicker!
    @IBOutlet weak var consultaFin: UIDatePicker!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        spinner.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        
    }
    
    @IBAction func terminarRegistroPressed(_ sender: UIButton) {

        guard let direccion = consultorioTextField.text, !direccion.isEmpty  else {return}
        guard let phone = phoneTextField.text , !phone.isEmpty else {return}

        self.spinner.isHidden = false
        self.spinner.startAnimating()

        let horaConsultaIncio = Calendar.current.date(byAdding: .hour, value: -5, to: consultaInicio.date)//para obetenre la hora
        let horaConsultaFin = Calendar.current.date(byAdding: .hour, value: -5, to: consultaFin.date)// para setear la hora
        let dataToSave: [String: Any] = ["nombre": name, "telefono": phone, "direccion": direccion, "horaEntrada": horaConsultaIncio, "horaSalida": horaConsultaFin]
        let userType: [String: Any] = ["tipo":"doctor"]

      

        var userId: String!
        let user = Auth.auth().currentUser
        if let user = user {
            userId = user.email
        }


        docRef = Firestore.firestore().document("doc/\(userId!)")
        docRef?.setData(dataToSave) { (error) in

            if error != nil{

                self.spinner.stopAnimating()
                self.spinner.isHidden = true

                let alert = UIAlertController(title: "Error", message: "Ocurrió un error, intenéntelo más tarde",preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true, completion: nil)
                //
            }else{

            }//
        }
        

        
        
        //self.performSegue(withIdentifier: "unwindConsultasFromRegistro", sender: self)

        docRef = Firestore.firestore().document("user/\(userId!)")
        docRef?.setData(userType) { (error) in
            if error != nil{
                print("Ocurrió un error al guardar el tipo")
            }else{
                print("bien tipo")
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                self.performSegue(withIdentifier: "unwindConsultasFromRegistro", sender: self)
            }
        }
self.performSegue(withIdentifier: "unwindConsultasFromRegistro", sender: self)
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

