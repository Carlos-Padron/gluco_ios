//
//  pacienteCellTableViewCell.swift
//  Gluco
//
//  Created by Carlos Padrón on 11/3/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit

class pacienteCell: UITableViewCell {
    
    
    @IBOutlet weak var pacienteInfo: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInfo(info:String){
        print("seteando")
        self.pacienteInfo.text = info
    }

}
