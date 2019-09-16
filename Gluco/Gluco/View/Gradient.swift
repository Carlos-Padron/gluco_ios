//
//  Gradient.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/15/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit
@IBDesignable

class  Gradient: UIView {

    //Codigo para hacer la gradiente
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBInspectable var topColor:UIColor = UIColor.init(red: CGFloat(10) / 255.0, green: CGFloat(73) / 255.0, blue: CGFloat(123) / 255.0, alpha: 1.0){
        didSet{
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor:UIColor = UIColor.init(red: CGFloat(31) / 255.0, green: CGFloat(69) / 255.0, blue: CGFloat(84) / 255.0, alpha: 1.0){
        didSet{
            self.setNeedsLayout()
        }
    }

}
