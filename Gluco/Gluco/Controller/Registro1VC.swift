//
//  Registro1VC.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/28/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit

class Registro1VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       

        let back = UIBarButtonItem()
        back.title = ""
        navigationItem.backBarButtonItem = back
        navigationController?.navigationBar.tintColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    

    @IBAction func registrarPressed(_ sender: Any) {
       self.performSegue(withIdentifier: "CompletarRegistroSegue", sender: self)
    }
    

}
