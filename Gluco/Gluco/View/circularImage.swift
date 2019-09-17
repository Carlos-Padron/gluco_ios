//
//  circularImage.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/16/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit
@IBDesignable
class circularImage: UIImageView {

    override func awakeFromNib() {
        setUpView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func setUpView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
}
