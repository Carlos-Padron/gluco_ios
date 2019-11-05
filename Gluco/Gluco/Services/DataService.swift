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
    typealias CompletionHandler = (_ Success: Bool) -> ()

    
    
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
    
    //Picker services
    
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
    
    private var pacientesArray = [pacientes]()
    private var pacienteInfoArray = [String]()
    
    func getPacientes() -> [pacientes]{
        return pacientesArray
    }
    
    func getPacienteInfo() -> [String]{
        return pacienteInfoArray
    }
    
    //User services
    
    private var doctor = [String]()
    private var user = [String]()
    
    func getDoctorInfo() -> [String]{
        return doctor
    }
    
    func getUserInfo() -> [String]{
    return user
    }
    
    //Dietas services
    
    private let tipoComida = ["Almuerzo", "Comida", "Cena", "Alimentos permitidos"]
    private var nombreDieta1: String?
    private var nombreDieta2: String?
    private var nombreDieta3: String?
    private var dieta1Array = [String]()
    private var dieta2Array = [String]()
    private var dieta3Array = [String]()
    
    
    func getDieta1() -> [String] {
        return dieta1Array
    }
    
    func getDieta2()  -> [String]{
        return dieta2Array
    }
    
    func getDieta3()  -> [String]{
        return dieta3Array
    }
    
    func getTipoComida() -> [String]{
        return tipoComida
    }
    
    func getNombreDieta1() -> String{
        return nombreDieta1 ?? ""
    }
    
    func getNombreDieta2() -> String{
        return nombreDieta2 ?? ""
    }
    
    func getNombreDieta3() -> String{
        return nombreDieta3 ?? ""
    }
    
    
    //Mediciones services
    
    private var medicionesArray = [mediciones]()
    
    func getMediciones() -> [mediciones]{
        return medicionesArray
    }

    
    //Functions
    
    func setPacienteInfo(index: Int){
        self.pacienteInfoArray.removeAll()
        self.pacienteInfoArray.append("Nombre: \(pacientesArray[index].nombre)")
        self.pacienteInfoArray.append("Género: \(pacientesArray[index].genero)")
        self.pacienteInfoArray.append("Nacimiento: \(pacientesArray[index].nacimiento)")
        self.pacienteInfoArray.append("Tipo de diabetes: \(pacientesArray[index].diabetes)")
        print(pacienteInfoArray)
    }
    
    
    func getPaccientesFromFB(){
        let id = Auth.auth().currentUser?.email
        print(id!)
        Firestore.firestore().collection("paciente").whereField("doctor", isEqualTo: id! ).getDocuments { (querySnapshot, error) in
            if let error = error{
                print("error al traer docs")
            }else{
                for document in querySnapshot!.documents {
                    
                    let nombre = document.data()["nombre"] as! String
                    let email = document.data()["email"] as! String
                    let genero = document.data()["genero"] as! String
                    let nacimiento = document.data()["nacimiento"] as! String
                    let doctor = document.data()["doctor"] as! String
                    let diabetes = document.data()["diabetes"] as! String
                    
                    let paciente = pacientes(nombre: nombre, genero: genero, nacimiento: nacimiento, diabetes: diabetes, doctor: doctor, email: email)
                    
                    self.pacientesArray.append(paciente)
                    print(self.getPacientes()[0].email)
                }
                self.setInitialDieta1()
                self.setInitialDieta2()
                self.setInitialDieta3() 
                
            }
        }
    }
    
    
    func setInitialDieta1(){
        
        if Auth.auth().currentUser != nil {
            
        var dieta1: DocumentReference!
        
        let email = DataService.instance.getPacientes()
            if email.count != 0 {
                dieta1 = Firestore.firestore().document("dietas/\(email[0].email)-dieta1")
                dieta1.getDocument { (docSnapshot, error) in
                    if let doc1 = docSnapshot, doc1.exists {
                        
                        
                        let nombre = doc1.data()!["nombreDieta"]
                        let almuerzo = doc1.data()!["almuerzo"]
                        let comida = doc1.data()!["comida"]
                        let cena = doc1.data()!["cena"]
                        let comidaExtra = doc1.data()!["comidaExtra"]
                        
                        let dietaUno = dietas(nombre: nombre as! String, almuerzo: almuerzo as! String, comida: comida as! String, cena: cena as! String, comidaExtra: comidaExtra as! String )
                        
                        self.dieta1Array.append(dietaUno.almuerzo!)
                        self.dieta1Array.append(dietaUno.comida!)
                        self.dieta1Array.append( dietaUno.cena!)
                        self.dieta1Array.append(dietaUno.comidaExtra!)
                        self.nombreDieta1 = dietaUno.nombre!
                        print(self.nombreDieta1 )
                        print("hay dieta")
                    }
                }
            }
        }
    }
    
    func setInitialDieta2(){
         if Auth.auth().currentUser != nil {
        
        var dieta2: DocumentReference!
        let email = DataService.instance.getPacientes()
            if email.count != 0 {
                dieta2 = Firestore.firestore().document("dietas/\(email[0].email)-dieta2")
                dieta2.getDocument { (docSnapshot, error) in
                    if let doc2 = docSnapshot, doc2.exists {
                        
                        
                        let nombre = doc2.data()!["nombreDieta"]
                        let almuerzo = doc2.data()!["almuerzo"]
                        let comida = doc2.data()!["comida"]
                        let cena = doc2.data()!["cena"]
                        let comidaExtra = doc2.data()!["comidaExtra"]
                        
                        let dietaDos = dietas(nombre: nombre as! String, almuerzo: almuerzo as! String, comida: comida as! String, cena: cena as! String, comidaExtra: comidaExtra as! String )
                        
                        self.dieta2Array.append(dietaDos.almuerzo!)
                        self.dieta2Array.append(dietaDos.comida!)
                        self.dieta2Array.append(dietaDos.cena!)
                        self.dieta2Array.append(dietaDos.comidaExtra!)
                        self.nombreDieta2 = dietaDos.nombre!
                        print(self.nombreDieta2)
                        print("hay dieta")
                    }
                }
            }
        }
    }
    
    func setInitialDieta3(){
         if Auth.auth().currentUser != nil {
        
        var dieta3: DocumentReference!
        let email = DataService.instance.getPacientes()
            if email.count != 0 {
                dieta3 = Firestore.firestore().document("dietas/\(email[0].email)-dieta3")
                dieta3.getDocument { (docSnapshot, error) in
                    if let doc3 = docSnapshot, doc3.exists {
                        
                        
                        let nombre = doc3.data()!["nombreDieta"]
                        let almuerzo = doc3.data()!["almuerzo"]
                        let comida = doc3.data()!["comida"]
                        let cena = doc3.data()!["cena"]
                        let comidaExtra = doc3.data()!["comidaExtra"]
                        
                        let dietaTres = dietas(nombre: nombre as! String, almuerzo: almuerzo as! String, comida: comida as! String, cena: cena as! String, comidaExtra: comidaExtra as! String )
                        
                        self.dieta3Array.append(dietaTres.almuerzo!)
                        self.dieta3Array.append(dietaTres.comida!)
                        self.dieta3Array.append(dietaTres.cena!)
                        self.dieta3Array.append(dietaTres.comidaExtra!)
                        self.nombreDieta3 = dietaTres.nombre
                        print("hay dieta")
                    }
                }
            }
        }
    }
    
    /////
    
    func fillDieta1(email:String){
        var dieta1: DocumentReference!
        dieta1 = Firestore.firestore().document("dietas/\(email)-dieta1")
        dieta1.getDocument { (docSnapshot, error) in
            if let doc1 = docSnapshot, doc1.exists {
                
                
                let nombre = doc1.data()!["nombreDieta"]
                let almuerzo = doc1.data()!["almuerzo"]
                let comida = doc1.data()!["comida"]
                let cena = doc1.data()!["cena"]
                let comidaExtra = doc1.data()!["comidaExtra"]
                
                let dietaUno = dietas(nombre: nombre as! String, almuerzo: almuerzo as! String, comida: comida as! String, cena: cena as! String, comidaExtra: comidaExtra as! String )

                self.dieta1Array.removeAll()
                self.dieta1Array.append(dietaUno.almuerzo!)
                self.dieta1Array.append(dietaUno.comida!)
                self.dieta1Array.append( dietaUno.cena!)
                self.dieta1Array.append(dietaUno.comidaExtra!)
                self.nombreDieta1 = dietaUno.nombre!

                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
            }else{
                 self.dieta1Array.removeAll()
                self.nombreDieta1 = nil
                 NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
            }
        }
    }
    
    func fillDieta2(email:String){
        var dieta2: DocumentReference!
        dieta2 = Firestore.firestore().document("dietas/\(email)-dieta2")
        dieta2.getDocument { (docSnapshot, error) in
            if let doc2 = docSnapshot, doc2.exists {
                
                
                let nombre = doc2.data()!["nombreDieta"]
                let almuerzo = doc2.data()!["almuerzo"]
                let comida = doc2.data()!["comida"]
                let cena = doc2.data()!["cena"]
                let comidaExtra = doc2.data()!["comidaExtra"]
                
                let dietaDos = dietas(nombre: nombre as! String, almuerzo: almuerzo as! String, comida: comida as! String, cena: cena as! String, comidaExtra: comidaExtra as! String )
                
                self.dieta2Array.removeAll()
                self.dieta2Array.append(dietaDos.almuerzo!)
                self.dieta2Array.append(dietaDos.comida!)
                self.dieta2Array.append(dietaDos.cena!)
                self.dieta2Array.append(dietaDos.comidaExtra!)
                print(self.dieta2Array)
                self.nombreDieta2 = dietaDos.nombre!
                print("se llegó a la notificacion")
                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
            }else{
                self.dieta2Array.removeAll()
                self.nombreDieta2 = nil
                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
            }
        }
    }
    
    func fillDieta3(email: String){
        var dieta3: DocumentReference!
        dieta3 = Firestore.firestore().document("dietas/\(email)-dieta3")
        dieta3.getDocument { (docSnapshot, error) in
            if let doc3 = docSnapshot, doc3.exists {
                
                let nombre = doc3.data()!["nombreDieta"]
                let almuerzo = doc3.data()!["almuerzo"]
                let comida = doc3.data()!["comida"]
                let cena = doc3.data()!["cena"]
                let comidaExtra = doc3.data()!["comidaExtra"]
                
                let dietaTres = dietas(nombre: nombre as! String, almuerzo: almuerzo as! String, comida: comida as! String, cena: cena as! String, comidaExtra: comidaExtra as! String )
                
                self.dieta3Array.removeAll()
                self.dieta3Array.append(dietaTres.almuerzo!)
                self.dieta3Array.append(dietaTres.comida!)
                self.dieta3Array.append(dietaTres.cena!)
                self.dieta3Array.append(dietaTres.comidaExtra!)
                self.nombreDieta3 = dietaTres.nombre!
                print("fill d3")
                print(self.dieta3Array)
                 NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
            }else{
                self.dieta3Array.removeAll()
                self.nombreDieta3 = nil
                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
            }
        }
    }
    
    ////
    
    func deleteDieta1(email : String){
        var dieta1: DocumentReference!
        dieta1 = Firestore.firestore().document("dietas/\(email)-dieta1")
        dieta1.delete { (error) in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                self.dieta1Array.removeAll()
                self.nombreDieta1 = nil
                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                //actualizar tabla
                print("Document successfully removed!1")
            }
        }
    }
    
    func deleteDieta2(email : String){
        var dieta2: DocumentReference!
        dieta2 = Firestore.firestore().document("dietas/\(email)-dieta2")
        dieta2.delete { (error) in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                self.dieta2Array.removeAll()
                self.nombreDieta2 = nil
               NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                print("Document successfully removed!2")
            }
        }
    }
    
    func deleteDieta3(email : String){
        var dieta3: DocumentReference!
        dieta3 = Firestore.firestore().document("dietas/\(email)-dieta3")
        dieta3.delete { (error) in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                self.dieta3Array.removeAll()
                self.nombreDieta3 = nil
                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
            }
        }
    }
    

   
    func logOut(){
        self.dieta1Array.removeAll()
        self.dieta2Array.removeAll()
        self.dieta3Array.removeAll()
        self.nombreDieta1 = nil
        self.nombreDieta2 = nil
        self.nombreDieta3 = nil
        self.pacientesArray.removeAll()
        self.pacienteInfoArray.removeAll()
        self.doctor.removeAll()
        self.user.removeAll()
        self.medicionesArray.removeAll()
    }
    
    func fecthInfoFromFB(email:String){
        print(variables.userType)
        self.doctor.removeAll()
        self.user.removeAll()
        if variables.userType == "doctor" {
            var userDoc: DocumentReference!
            userDoc = Firestore.firestore().document("doc/\(email)")
            userDoc.getDocument { (docSnapshot, error) in
                if let doc = docSnapshot, doc.exists {
                    
                    let nombre = doc.data()!["nombre"]
                    let telefono = doc.data()!["telefono"]
                    let direccion = doc.data()!["direccion"]
                    let horaEntrada = doc.data()!["horaEntrada"]
                    let horaSalida = doc.data()!["horaSalida"]
                    
                    self.doctor.append(nombre as! String)
                    self.doctor.append(telefono as! String)
                    self.doctor.append(direccion as! String)
                    self.doctor.append(horaEntrada as! String)
                    self.doctor.append(horaSalida as! String)
                    print(self.doctor)
                   NotificationCenter.default.post(name: NSNotification.Name("ReloadProfile"), object: nil)
                }
            }//
        }
        if variables.userType == "paciente"{
            var userDoc: DocumentReference!
            userDoc = Firestore.firestore().document("paciente/\(email)")
            userDoc.getDocument { (docSnapshot, error) in
                if let doc = docSnapshot, doc.exists {
                    
                    let nombre = doc.data()!["nombre"]
                    let genero = doc.data()!["genero"]
                    let nacimiento = doc.data()!["nacimiento"]
                    let email = doc.data()!["email"]
                    let doctor = doc.data()!["doctor"]
                    let diabetes = doc.data()!["diabetes"]
                    
                    self.user.append(nombre as! String)
                    self.user.append(genero as! String)
                    self.user.append(nacimiento as! String)
                    self.user.append(email as! String)
                    self.user.append(doctor as! String)
                    self.user.append(diabetes as! String)
                    
                   NotificationCenter.default.post(name: NSNotification.Name("ReloadProfile"), object: nil)
                }
            }//
        }
    
    }
    
    func getMedicionesFromFB(email:String, fecha:String){
        print("en dS")
        print(email)
        print(fecha)
        print("04-11-2019")
        self.medicionesArray.removeAll()
        //.whereField("fecha", isEqualTo: fecha).
        Firestore.firestore().collection("mediciones").whereField("email", isEqualTo: email).whereField("fecha", isEqualTo: fecha).order(by: "hora").getDocuments { (QuerySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in QuerySnapshot!.documents {
                    let email = document.data()["email"]
                    let fecha = document.data()["fecha"]
                    let hora = document.data()["hora"]
                    let medicion = document.data()["medicion"]
                    let observacion = document.data()["observacion"]
                    
                    let medicionObj = mediciones(email: email as! String, fecha: fecha as! String, hora: hora as! String, medicion: medicion as! String, observacion: observacion as! String)
                    self.medicionesArray.append(medicionObj )
                    print(self.medicionesArray[0].email)
                    NotificationCenter.default.post(name: NSNotification.Name("recargarMedicion"), object: nil)
                    
                    
                }
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name("recargarMedicion"), object: nil)
    }
    
    
    
}//
