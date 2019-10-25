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
        self.descripcionComidaLabel.text = description
    }
    
    func setHeader(nombreDieta: String){
        self.dietaLabel.text = nombreDieta
        self.deleteBtn.setImage(deleteImg, for: .normal)
        self.editBtn.setImage(editImg, for: .normal)
        
    }
    


    @IBAction func deletePressed(_ sender: UIButton) {
        if sender.tag == 1 {
            
        }
        if sender.tag == 2 {
            
        }
        if sender.tag == 3 {
            
        }
    }
    
    
    @IBAction func editPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            
        }
        if sender.tag == 2 {
            
        }
        if sender.tag == 3 {
            
        }
    }
    
    
    //Agregar Dietas
    func searchDocReferenc(){
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
