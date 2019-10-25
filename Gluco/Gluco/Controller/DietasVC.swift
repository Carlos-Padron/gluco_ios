//
//  DietasVCViewController.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/22/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit

class DietasVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   

    
    //Outlets
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var addDieta: UIButton!
    @IBOutlet weak var pacientePicker: UIPickerView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pacientePicker.dataSource = self
        pacientePicker.delegate = self
        setUpSWReveal()
    }
    

    func setUpSWReveal(){
        menuBtn.target = self.revealViewController()
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DataService.instance.getPacientes().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DataService.instance.getPacientes()[row]
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        <#code#>
    }
    
    
    
    @IBAction func addPressed(_ sender: Any) {
        let modalDietas = AddDietas()
        modalDietas.modalPresentationStyle = .custom
        present(modalDietas, animated: true)
        
        
        //consulta para ver si hay 3
        
        
        //performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)// a AddDietas.xib
    }
    
    
    
}//

    

