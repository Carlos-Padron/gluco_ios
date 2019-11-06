//
//  menuCell.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/19/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit

class menuCell: UITableViewCell {

    
    @IBOutlet weak var menuIcon: UIImageView!
    
    
    @IBOutlet weak var menuTitle: UILabel!
    
    
    func updateMenu(Menu : menu){
        menuIcon.image = UIImage(named: Menu.menuIcon)
        menuTitle.text = Menu.menuTitle
        self.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    
    
////////////////////////////////////////////////
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
