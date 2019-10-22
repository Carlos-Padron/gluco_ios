//
//  DataService.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/19/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import Foundation

struct DataService {
     static let instance = DataService()
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
    
}//
