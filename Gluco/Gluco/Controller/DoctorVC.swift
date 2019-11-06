//
//  DoctorVC.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/22/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit

class DoctorVC: UIViewController {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSWReveal()
    }
    

    func setUpSWReveal(){
        menuBtn.target = self.revealViewController()
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    

}
