//
//  medicionCell.swift
//  Gluco
//
//  Created by Carlos Padrón on 11/4/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit

class medicionCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var medicionLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var horaLabel: UILabel!
    @IBOutlet weak var observacionLabel: UITextView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpTable(medicion : mediciones){
        
        self.medicionLabel.text = "Medicion: \(medicion.medicion!) mg/dl"
        self.fechaLabel.text = "Fecha: \(medicion.fecha!)"
        self.horaLabel.text = "Hora: \(medicion.hora!)"
        self.observacionLabel.text = medicion.observacion!
    }

}
