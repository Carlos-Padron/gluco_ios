//
//  pacientes.swift
//  Gluco
//
//  Created by Carlos Padrón on 10/23/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import Foundation
import Firebase

class pacientes {
    private (set) var nombre: String
    private (set) var genero: String
    private (set) var nacimiento: Timestamp
    private (set) var diabetes: String
    private (set) var doctor: String
    private (set) var email: String
    
    init(nombre: String, genero: String, nacimiento: Timestamp, diabetes: String, doctor: String, email: String) {
        self.nombre = nombre
        self.genero = genero
        self.nacimiento = nacimiento
        self.diabetes = diabetes
        self.doctor = doctor
        self.email = email
    }
    
}
