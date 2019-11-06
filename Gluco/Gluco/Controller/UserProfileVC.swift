//
//  UserProfileVC.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/22/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKB()
        // Do any additional setup after loading the view.
    }


    @IBAction func modalClosed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func dismissKB(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UserProfileVC.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    

    @objc func dismissKeyboard(){
        view.endEditing(true)
        print("dismiss")
    }

}
