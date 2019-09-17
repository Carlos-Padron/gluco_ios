//
//  MenuVC.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/15/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    
    override func viewDidLoad() {
        self.revealViewController().rearViewRevealWidth = (self.view.frame.size.width - 40)
    }
    

}
