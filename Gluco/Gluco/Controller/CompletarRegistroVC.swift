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
 
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func terminarRegistroPressed(_ sender: UIButton) {

        guard let direccion = consultorioTextField.text, !direccion.isEmpty  else {return}
        guard let phone = phoneTextField.text , !phone.isEmpty else {return}
        

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
                print("Ocurrió un error al guardar la info")
            }else{
                self.docRef = Firestore.firestore().document("user/\(userId!)")
                self.docRef?.setData(userType) { (error) in
                    if error != nil{
                        print("Ocurrió un error al guardar el tipo")
                    }else{
                        print("bien tipo")
                        self.performSegue(withIdentifier: "unwindConsultasFromRegistro", sender: self)
                    }
                }
            }
        }

//        docRef = Firestore.firestore().document("user/\(userId!)")
//        docRef?.setData(userType) { (error) in
//            if error != nil{
//                print("Ocurrió un error al guardar el tipo")
//            }else{
//                print("bien tipo")
//            }
//        }

        
        
        
    }
    
    


}

