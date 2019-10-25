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
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
        guard let alimentos = alimentosTextField.text, !alimentos.isEmpty else {return}
        
        
        
        
        dieta1 = Firestore.firestore().document("dietas/dieta1")
        dieta1.getDocument { (docSnapshot, error) in
            let doc1 = docSnapshot
            if doc1!.exists{
                //obtenemos los datos
            }else{
                //hacer inserciones
            }
        }
        
        dieta2 = Firestore.firestore().document("dietas/dieta2")
        dieta2.getDocument { (docSnapshot, error) in
            let doc2 = docSnapshot
            if doc2!.exists{
                //obtener datos
            }else{
                //hacer inserciones
            }
        }
        
        
        dieta3 = Firestore.firestore().document("dietas/dieta2")
        dieta3.getDocument { (docSnapshot, error) in
            let doc3 = docSnapshot
            if doc3!.exists {
                //obtener datos
            }else{
                //hacer inserciones
            }
        }
        
        
        
    }
    
    

}
