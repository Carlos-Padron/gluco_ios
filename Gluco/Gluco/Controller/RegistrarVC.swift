//
//  RegistrarVC.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/22/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit

class RegistrarVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //Variables
    var genero: String?
    var diabetes: String?

    
    //Outlets
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pw1TextField: UITextField!
    @IBOutlet weak var pw2TextFiled: UITextField!
    @IBOutlet weak var generoPicker: UIPickerView!
    @IBOutlet weak var diabetesPicker: UIPickerView!
    @IBOutlet weak var nacimientoPicker: UIDatePicker!
    

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
    

    @IBAction func registrarPressed(_ sender: UIButton) {
   print(genero!)
        print(diabetes!)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == diabetesPicker{
            return DataService.instance.getDiabetes().count
        }
        if pickerView == generoPicker {
            return DataService.instance.getGenero().count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == diabetesPicker{
            return DataService.instance.getDiabetes()[row]
        }
        if pickerView == generoPicker {
            return DataService.instance.getGenero()[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == diabetesPicker{//detalle aquí
            diabetes = DataService.instance.getDiabetes()[row]
        }
        if pickerView == generoPicker {
            genero = DataService.instance.getGenero()[row]
        }
    }
    
    
    
}//
