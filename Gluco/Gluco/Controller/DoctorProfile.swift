//
//  DoctorProfile.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/24/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit

class DoctorProfile: UIViewController {

    @IBOutlet weak var addressTextFile: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKB()
        addressTextFile.layer.borderColor = #colorLiteral(red: 0.9724436402, green: 0.972609818, blue: 0.9724331498, alpha: 1)

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
