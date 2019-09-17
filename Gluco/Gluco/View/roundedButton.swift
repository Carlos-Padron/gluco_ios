//
//  roundedButton.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/16/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit


class roundedButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpColor()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpColor()
    }
    
   func setUpColor(){
    self.layer.cornerRadius = 10
    self.layer.backgroundColor = UIColor.red.cgColor
    }

}
