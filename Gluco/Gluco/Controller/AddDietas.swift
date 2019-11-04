//
//  AddDietas.swift
//  Gluco
//
//  Created by Carlos Padrón on 10/25/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit
import Firebase

class AddDietas: UIViewController {
    
    //Outlets
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var desayunoTextField: UITextField!
    @IBOutlet weak var comidaTextField: UITextField!
    @IBOutlet weak var cenaTextFiled: UITextField!
    @IBOutlet weak var alimentosTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var modalTitle: UILabel!
    
    
    //Variables
    var dieta1: DocumentReference!
    var dieta2: DocumentReference!
    var dieta3: DocumentReference!
    var email : String!
    var operation: Int = 0
    var contentView: UIView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(email!)
        print(operation)
        // Do any additional setup after loading the view.
    }

    @IBAction func addPressed(_ sender: UIButton) {
        
        if nombreTextField.text == nil || desayunoTextField.text == nil || comidaTextField.text == nil ||
            cenaTextFiled.text == nil || alimentosTextField.text == nil {
            return
        }
        if operation == 0 {
            addDieta()
        }
        if operation == 1 {
            self.button.isUserInteractionEnabled = false
            editDieta1()
            operation = 0
        }
        if operation == 2 {
            self.button.isUserInteractionEnabled = false
            editDieta2()
            operation = 0
        }
        if operation == 3 {
            self.button.isUserInteractionEnabled = false
            print("operacion 3")
            editDieta3()
            operation = 0
        }
        
    }
    
    
    func setDieta(nombre: String, desayuno: String,comida: String, cena: String, extra: String){
        nombreTextField?.text = nombre
        desayunoTextField?.text = desayuno
        comidaTextField?.text = comida
        cenaTextFiled?.text = cena
        alimentosTextField?.text = extra
        button.setTitle("Actualizar", for: .normal)
        modalTitle.text = "Actualizar"
    }
    
    
    
    func addDieta(){
        guard let dietaNombre = nombreTextField.text, !dietaNombre.isEmpty else {return}
        guard let desayuno = desayunoTextField.text, !desayuno.isEmpty else {return}
        guard let comida = comidaTextField.text, !comida.isEmpty  else {return}
        guard let cena = cenaTextFiled.text, !cena.isEmpty else {return}
         let alimentos = alimentosTextField.text//, !alimentos.isEmpty else {return}
        

        dieta1 = Firestore.firestore().document("dietas/\(email!)-dieta1")
        dieta2 = Firestore.firestore().document("dietas/\(email!)-dieta2")
        dieta3 = Firestore.firestore().document("dietas/\(email!)-dieta3")
        dieta1.getDocument { (docSnapshot, error) in
            if let doc1 = docSnapshot, doc1.exists {
                self.dieta2.getDocument(completion: { (docSnapshot, error) in
                    if let doc2 = docSnapshot, doc2.exists {
                        let dataToSave:[String: Any] = ["nombreDieta": dietaNombre , "almuerzo": desayuno, "comida": comida, "cena": cena, "comidaExtra": alimentos!, "email": self.email!, "numeroDieta": 3 ]
                        
                        self.dieta3.setData(dataToSave, completion: { (error) in
                            if error != nil {
                                let alert = UIAlertController(title: "Error", message: "Ocurrió un error, intenéntelo más tarde",preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                self.present(alert, animated: true, completion: nil)
                                
                            }else{
                                self.dismiss(animated: true, completion: {
                                     //
                                     DataService.instance.fillDieta3(email: self.email)
                                })
                            }
                        })
                    }else{
                        let dataToSave:[String: Any] = ["nombreDieta": dietaNombre , "almuerzo": desayuno, "comida": comida, "cena": cena, "comidaExtra": alimentos!, "email": self.email!, "numeroDieta": 2 ]
                        
                        self.dieta2.setData(dataToSave, completion: { (error) in
                            if error != nil {
                                let alert = UIAlertController(title: "Error", message: "Ocurrió un error, intenéntelo más tarde",preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                self.present(alert, animated: true, completion: nil)
                                
                            }else{
                                self.dismiss(animated: true, completion: {
                                   //
                                     DataService.instance.fillDieta2(email: self.email)
                                })
                            }
                        })
                    }
                })
                
            }else{
                let dataToSave:[String: Any] = ["nombreDieta": dietaNombre , "almuerzo": desayuno, "comida": comida, "cena": cena, "comidaExtra": alimentos!, "email": self.email!, "numeroDieta": 1 ]
                
                self.dieta1.setData(dataToSave, completion: { (error) in
                    if error != nil {
                        let alert = UIAlertController(title: "Error", message: "Ocurrió un error, intenéntelo más tarde",preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default))
                        self.present(alert, animated: true, completion: nil)
                        
                    }else{
                        self.dismiss(animated: true, completion: {
                            //
                            DataService.instance.fillDieta1(email: self.email)
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func editDieta1(){
        let dieta1: DocumentReference!
        guard let dietaNombre = nombreTextField.text, !dietaNombre.isEmpty else {return}
        guard let desayuno = desayunoTextField.text, !desayuno.isEmpty else {return}
        guard let comida = comidaTextField.text, !comida.isEmpty  else {return}
        guard let cena = cenaTextFiled.text, !cena.isEmpty else {return}
        let alimentos = alimentosTextField.text//, !alimentos.isEmpty else {return}
        
        dieta1 = Firestore.firestore().document("dietas/\(email!)-dieta1")
        dieta1.getDocument { (docSnapshot, error) in
            if let doc1 = docSnapshot, doc1.exists {
                let dataToSave:[String: Any] = ["nombreDieta": dietaNombre , "almuerzo": desayuno, "comida": comida, "cena": cena, "comidaExtra": alimentos!, "email": self.email, "numeroDieta": 1 ]
                
                dieta1.setData(dataToSave, completion: { (error) in
                    if error != nil {
                        let alert = UIAlertController(title: "Error", message: "Ocurrió un error, intenéntelo más tarde",preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default))
                        self.present(alert, animated: true, completion: nil)
                        
                    }else{//actualizar tabla
                        var dieta1 = DataService.instance.getDieta1()
                        dieta1.removeAll()
                        self.dismiss(animated: true, completion: {
                            DataService.instance.fillDieta1(email: self.email)
                        })
                        
                        
                    }
                })
            }
        }
        
    }
    
 
    func editDieta2(){
        let dieta2: DocumentReference!
        guard let dietaNombre = nombreTextField.text, !dietaNombre.isEmpty else {return}
        guard let desayuno = desayunoTextField.text, !desayuno.isEmpty else {return}
        guard let comida = comidaTextField.text, !comida.isEmpty  else {return}
        guard let cena = cenaTextFiled.text, !cena.isEmpty else {return}
        let alimentos = alimentosTextField.text//, !alimentos.isEmpty else {return}
        
        dieta2 = Firestore.firestore().document("dietas/\(email!)-dieta2")
        dieta2.getDocument { (docSnapshot, error) in
            if let doc1 = docSnapshot, doc1.exists {
                let dataToSave:[String: Any] = ["nombreDieta": dietaNombre , "almuerzo": desayuno, "comida": comida, "cena": cena, "comidaExtra": alimentos!, "email": self.email, "numeroDieta": 2 ]
                
                dieta2.setData(dataToSave, completion: { (error) in
                    if error != nil {
                        let alert = UIAlertController(title: "Error", message: "Ocurrió un error, intenéntelo más tarde",preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default))
                        self.present(alert, animated: true, completion: nil)
                        
                    }else{//actualizar tabla
                        var dieta2 = DataService.instance.getDieta2()
                        dieta2.removeAll()
                        self.dismiss(animated: true, completion: {
                            DataService.instance.fillDieta2(email: self.email)
                        })
                        
                        
                    }
                })
            }
        }
        
    }//
    

    func editDieta3(){
        let dieta3: DocumentReference!
        guard let dietaNombre = nombreTextField.text, !dietaNombre.isEmpty else {return}
        guard let desayuno = desayunoTextField.text, !desayuno.isEmpty else {return}
        guard let comida = comidaTextField.text, !comida.isEmpty  else {return}
        guard let cena = cenaTextFiled.text, !cena.isEmpty else {return}
        let alimentos = alimentosTextField.text//, !alimentos.isEmpty else {return}
        
        dieta3 = Firestore.firestore().document("dietas/\(email!)-dieta3")
        dieta3.getDocument { (docSnapshot, error) in
            if let doc1 = docSnapshot, doc1.exists {
                let dataToSave:[String: Any] = ["nombreDieta": dietaNombre , "almuerzo": desayuno, "comida": comida, "cena": cena, "comidaExtra": alimentos!, "email": self.email, "numeroDieta": 3 ]
                
                dieta3.setData(dataToSave, completion: { (error) in
                    if error != nil {
                        let alert = UIAlertController(title: "Error", message: "Ocurrió un error, intenéntelo más tarde",preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default))
                        self.present(alert, animated: true, completion: nil)
                        
                    }else{//actualizar tabla
                        var dieta3 = DataService.instance.getDieta3()
                        dieta3.removeAll()
                        self.dismiss(animated: true, completion: {
                            DataService.instance.fillDieta3(email: self.email)
                        })
                        
                        
                    }
                })
            }
        }
        
    }//
    

 
    
}
