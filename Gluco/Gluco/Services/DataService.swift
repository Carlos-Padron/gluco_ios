//
//  DataService.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/19/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import Foundation
import Firebase

class DataService {
     static let instance = DataService()
    //Variables
    
    private var docRef: DocumentReference? = nil
    
    
    //Menu services
    private let doctorMenu = [
        menu(menuTitle: "Consultas", menuIcon: "eye"),
        menu(menuTitle: "Dietas", menuIcon: "health"),
        menu(menuTitle: "Registrar paciente", menuIcon: "userPlus")
    
    
    ]
    
    private let userMenu = [
        menu(menuTitle: "Medición", menuIcon: "gota"),
        menu(menuTitle: "Dietas", menuIcon: "health"),
        menu(menuTitle: "Doctor", menuIcon: "doctor")
    
    ]
    
    func getDoctorMenu()-> [menu] {
        return doctorMenu
    }
    
    func getUserMenu() -> [menu]{
        return userMenu
    }
    
    //Doctor/user services
    
    private let diabetes = [
    "Diabetes tipo 1", "Diabetes tipo 2"
    ]
    
    private let genero = [
    "Masculino", "Femenino"
    ]
    
    func getDiabetes() -> [String]{
        return diabetes
    }
    
    func getGenero() -> [String]{
        return genero
    }
    
    //pacientes services
    
    private var pacientesArray = [String]()
    
    func getPacientes() -> [String]{
        return pacientesArray
    }
    
    
    
    
    //Functions
    
    func getPaccientesFromFB(){
        let id = Auth.auth().currentUser?.email
        Firestore.firestore().collection("paciente").whereField("doctor", isEqualTo: id! ).getDocuments { (querySnapshot, error) in
            if let error = error{
                print("error al traer docs")
            }else{
                for document in querySnapshot!.documents {
                    
                    let nombre = document.data()["nombre"] as! String
                    self.pacientesArray.append(nombre)
                }
            }
        }
    }
    
    
}//
