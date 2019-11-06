//
//  DoctorProfile.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/24/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit
import Firebase

class DoctorProfile: UIViewController {
    
    
    //Outlets
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var telefonoTextField: UITextField!
    @IBOutlet weak var addressTextFile: UITextView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var horarioEntradaPIcker: UIDatePicker!
    @IBOutlet weak var horarioSalidaPicker: UIDatePicker!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //Variables
    
    var docRef: DocumentReference? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKB()
        addressTextFile.layer.borderColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        self.spinner.isHidden = true
        
        // Do any additional setup after loading the view.
    }

    @IBAction func modalClosed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func dismissKB(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UserProfileVC.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
        print("dismiss")
    }

    func setInfo(titulo:String, nombre: String, telefono:String, direccion:String, hEntrada:String, hSalida: String){
        
        let formatterE = DateFormatter()
        formatterE.dateFormat = "HH:mm"
        let e = formatterE.date(from: hEntrada)
        let formatterS = DateFormatter()
        formatterS.dateFormat = "HH:mm"
        let s = formatterS.date(from: hSalida)
        print(e ?? "no")
        print(s ?? "no")
        
        self.nameLable.text = titulo
        self.nombreTextField.text = nombre
        self.telefonoTextField.text = telefono
        self.addressTextFile.text = direccion
        self.horarioEntradaPIcker.date = e!
        self.horarioSalidaPicker.date = s!
    }
    @IBAction func actualizarPerfilPressed(_ sender: Any) {
        let email = Auth.auth().currentUser?.email
        docRef = Firestore.firestore().document("doc/\(email!)")
        guard let nombre = nombreTextField.text, !nombre.isEmpty else {return}
        guard let telefono = telefonoTextField.text, !telefono.isEmpty else {return}
        guard let direccion = addressTextFile.text, !direccion.isEmpty else {return}
        
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let dataToSave: [String: Any] = ["nombre": nombre, "telefono": telefono, "direccion": direccion, "horaEntrada": dateFormatter.string(from: horarioEntradaPIcker.date ), "horaSalida": dateFormatter.string(from:
            horarioSalidaPicker.date)]
        
        docRef?.setData(dataToSave) { (error) in
            
            if error != nil{
                self.view.isUserInteractionEnabled = true
                let alert = UIAlertController(title: "Error", message: "Ocurrió un error, intenéntelo más tarde",preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true, completion: nil)
                //
            }else{
                DataService.instance.fecthInfoFromFB(email: email!)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }//
    
}
