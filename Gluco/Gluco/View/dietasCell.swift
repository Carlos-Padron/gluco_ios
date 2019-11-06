//
//  dietasCellTableViewCell.swift
//  Gluco
//
//  Created by Carlos Padrón on 10/23/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit
import Firebase

class dietasCell: UITableViewCell {

    //Outlets
    
    @IBOutlet weak var dietaLabel: UILabel!
    @IBOutlet weak var tipoComidaLabel: UILabel!
    @IBOutlet weak var descripcionComidaLabel: UITextView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    
    //Variables
    let deleteImg = UIImage(named: "deleteBtn")
    let editImg = UIImage(named: "editBtn")
    
///////
    var dieta1: DocumentReference!
    var dieta2: DocumentReference!
    var dieta3: DocumentReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func fillTable(tipoComida: String, descripcion:String){
        self.tipoComidaLabel.text = tipoComida
        self.descripcionComidaLabel.text = descripcion
        print("seteando tabla")
    }
    
    func setHeader(nombreDieta: String){
        self.dietaLabel.text = nombreDieta
        self.deleteBtn.setBackgroundImage(deleteImg, for: .normal)
        self.editBtn.setBackgroundImage(editImg, for: .normal)
        print("seteando header")
    }
    


    @IBAction func deletePressed(_ sender: UIButton) {
        if sender.tag == 1 {
            let dietasVC = DietasVC()
            var email = dietasVC.email
            if email == nil { email = DataService.instance.getPacientes()[0].email}
            print(email!)
            DataService.instance.deleteDieta1(email: email!)
        }
        if sender.tag == 2 {
            let dietasVC = DietasVC()
            var email = dietasVC.email
            if email == nil { email = DataService.instance.getPacientes()[0].email}
            print(email!)
            DataService.instance.deleteDieta2(email: email!)
        }
        if sender.tag == 3 {
            let dietasVC = DietasVC()
            var email = dietasVC.email
            if email == nil { email = DataService.instance.getPacientes()[0].email}
            print(email!)
            DataService.instance.deleteDieta3(email: email!)
        }
    }
    
    
    @IBAction func editPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            let name = DataService.instance.getNombreDieta1()
            var dieta = DataService.instance.getDieta1()
            print("1")
            let modal = AddDietas()
            let dietasC = DietasVC()
            if dietasC.email == nil {
                modal.email = DataService.instance.getPacientes()[0].email
            }else{
                modal.email = dietasC.email!
            }
            modal.operation = 1
            modal.modalPresentationStyle = .custom
            self.window?.rootViewController?.present(modal, animated: true, completion: nil)
            modal.setDieta(nombre: name, desayuno: dieta[0] as String, comida: dieta[1] as String, cena: dieta[2] as String, extra: dieta[3] as String)
        }
        if sender.tag == 2 {
            let name = DataService.instance.getNombreDieta2()
            var dieta = DataService.instance.getDieta2()
            let modal = AddDietas()
            let dietasC = DietasVC()
            if dietasC.email == nil {
                modal.email = DataService.instance.getPacientes()[0].email
            }else{
                modal.email = dietasC.email!
            }
            modal.operation = 2
            modal.modalPresentationStyle = .custom
            self.window?.rootViewController?.present(modal, animated: true, completion: nil)
            modal.setDieta(nombre: name, desayuno: dieta[0] as String, comida: dieta[1] as String, cena: dieta[2] as String, extra: dieta[3] as String)
        }
        if sender.tag == 3 {
            let name = DataService.instance.getNombreDieta3()
            var dieta = DataService.instance.getDieta3()
            let modal = AddDietas()
            let dietasC = DietasVC()
            if dietasC.email == nil {
                modal.email = DataService.instance.getPacientes()[0].email
            }else{
                modal.email = dietasC.email!
            }
            modal.operation = 3
            modal.modalPresentationStyle = .custom
            self.window?.rootViewController?.present(modal, animated: true, completion: nil)
            modal.setDieta(nombre: name, desayuno: dieta[0] as String, comida: dieta[1] as String, cena: dieta[2] as String, extra: dieta[3] as String)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
