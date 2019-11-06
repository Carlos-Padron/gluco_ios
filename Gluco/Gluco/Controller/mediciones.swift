//
//  mediciones.swift
//  Gluco
//
//  Created by Carlos Padrón on 10/23/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import Foundation
public class mediciones {
     private (set) var email: String?
      private (set) var fecha: String?
      private (set) var hora: String?
      private (set) var medicion: String?
      private (set) var observacion: String?
    
    init(email: String, fecha: String, hora: String, medicion: String, observacion: String) {
        self.email = email
        self.fecha = fecha
        self.hora = hora
        self.medicion = medicion
        self.observacion = observacion
    }
    
    func getFecha() -> String{
        return self.fecha!
    }
    
    func getHora() -> String{
        return self.hora!
    }
    
    func getMedicion() -> String{
        return self.medicion!
    }
    
    func getObservacion() -> String{
        return self.observacion!
    }
    
}
