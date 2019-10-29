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
    @IBOutlet weak var alimentosTextField: UITextView!
    
    //Variables
    var dieta1: DocumentReference!
    var dieta2: DocumentReference!
    var dieta3: DocumentReference!
    var email : String!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.alimentosTextField.isHidden = false
        print(email!)
        // Do any additional setup after loading the view.
    }

    @IBAction func addPressed(_ sender: UIButton) {
        addDieta()
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
                                self.dismiss(animated: true, completion: nil)
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
                                self.dismiss(animated: true, completion: nil)
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
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }//else
        }//fin getDoc

        
    }//fin del addDieta
    
    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    

    
//    func getDieta10(){
//        Firestore.firestore().collection("dietas").whereField("numeroDieta", isEqualTo: 1).whereField("email", isEqualTo: email!)
//            .getDocuments { (querySnapshot, error) in
//                if let error = error {
//                    print("Error getting documents: \(error)")
//                } else {
//                    for document in querySnapshot!.documents {
//                        let nombre = document.data()["nombreDieta"]
//                        let almuerzo = document.data()["almuerzo"]
//                        let comida = document.data()["comida"]
//                        let cena = document.data()["cena"]
//                        let comidaExtra = document.data()["comidaExtra"]
//
//                        let dietaUno = dietas(nombre: nombre as! String, almuerzo: almuerzo as! String, comida: comida as! String, cena: cena as! String, comidaExtra: comidaExtra as! String )
//
//                        var array = DataService.instance.getDieta1()
//                        array.append(dietaUno)
//                    }
//                }
//            }
//        }//
    
//    func getDieta2(){
//        Firestore.firestore().collection("dietas").whereField("numeroDieta", isEqualTo: 2).whereField("email", isEqualTo: email!)
//            .getDocuments { (querySnapshot, error) in
//                if let error = error {
//                    print("Error getting documents: \(error)")
//                } else {
//                    for document in querySnapshot!.documents {
//                        let nombre = document.data()["nombreDieta"]
//                        let almuerzo = document.data()["almuerzo"]
//                        let comida = document.data()["comida"]
//                        let cena = document.data()["cena"]
//                        let comidaExtra = document.data()["comidaExtra"]
//
//                        let dietaDos = dietas(nombre: nombre as! String, almuerzo: almuerzo as! String, comida: comida as! String, cena: cena as! String, comidaExtra: comidaExtra as! String )
//
//                        var array = DataService.instance.getDieta2()
//                        array.append(dietaDos)
//                    }
//                }
//            }
//        }//
//
//    func getDieta3(){
//        Firestore.firestore().collection("dietas").whereField("numeroDieta", isEqualTo: 3).whereField("email", isEqualTo: email!)
//            .getDocuments { (querySnapshot, error) in
//                if let error = error {
//                    print("Error getting documents: \(error)")
//                } else {
//                    for document in querySnapshot!.documents {
//                        let nombre = document.data()["nombreDieta"]
//                        let almuerzo = document.data()["almuerzo"]
//                        let comida = document.data()["comida"]
//                        let cena = document.data()["cena"]
//                        let comidaExtra = document.data()["comidaExtra"]
//
//                        let dietaTres = dietas(nombre: nombre as! String, almuerzo: almuerzo as! String, comida: comida as! String, cena: cena as! String, comidaExtra: comidaExtra as! String )
//
//                        var array = DataService.instance.getDieta3()
//                        array.append(dietaTres)
//                    }
//                }
//            }
//        }//
    
}
