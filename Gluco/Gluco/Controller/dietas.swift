//
//  dietas.swift
//  Gluco
//
//  Created by Carlos Padrón on 10/23/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import Foundation
class dietas {
    private (set) var nombre: String?
    private (set) var almuerzo: String?
    private (set) var comida: String?
    private (set) var cena: String?
    private (set) var comidaExtra:String?
    private (set) var email:String?
    
    init(nombre: String, almuerzo:String, comida:String, cena:String, comidaExtra:String, email:String) {
        self.nombre = nombre
        self.almuerzo = almuerzo
        self.comida = comida
        self.cena = cena
        self.comidaExtra = comidaExtra
        
        
    }
}
