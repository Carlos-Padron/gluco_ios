//
//  ConsultaVC.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/15/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit

class ConsultaVC: UIViewController {

    //IBOutlet

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSWReveal()
      isLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            // isLogin()
    }
    
    
    func setUpSWReveal(){
        menuBtn.target = self.revealViewController()
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    func isLogin(){
        if (true){
             self.performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }
    @IBAction func loginPressed(_ sender: UIStoryboardSegue) {
        
    }
//    cell.layer.masksToBounds = true
//    cell.layer.cornerRadius = 5
//    cell.layer.borderWidth = 2
//    cell.layer.shadowOffset = CGSize(width: -1, height: 1)
//    let borderColor: UIColor = #colorLiteral(red: 0.3792517781, green: 0.514690578, blue: 0.6138443947, alpha: 1)
//    cell.layer.borderColor = borderColor.cgColor
    
}
