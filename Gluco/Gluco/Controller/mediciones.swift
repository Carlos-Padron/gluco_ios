//
//  mediciones.swift
//  Gluco
//
//  Created by Carlos Padrón on 10/23/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import Foundation
class mediciones {
     private (set) var email: String?
      private (set) var fecha: Date?
      private (set) var hora: Date?
      private (set) var medicion: String?
      private (set) var observacion: String?
    
    init(email: String, fecha: Date, hora: Date, medicion: String, observacion: String) {
        self.email = email
        self.fecha = fecha
        self.hora = hora
        self.medicion = medicion
        self.observacion = observacion
    }
}
