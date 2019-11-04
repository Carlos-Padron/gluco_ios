//
//  ConsultaVC.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/15/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit

class ConsultaVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {

    //IBOutlet
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var pacienteTableview: UITableView!
    @IBOutlet weak var pacientesPicker: UIPickerView!
    
    //Variables
    var email: String!
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSWReveal()
       self.pacientesPicker.reloadAllComponents()
        self.reloadPicker()
    }
    
    
    func setUpSWReveal(){
        //self.revealViewController()?.navigationItem.leftBarButtonItem = menuBtn
        menuBtn.target = self.revealViewController()
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    func reloadPicker(){
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
             self.pacientesPicker.reloadAllComponents()
        }
    }

    @IBAction func unwindToConsultas(sender: UIStoryboardSegue) {}
    @IBAction func unwindToConsultasFromRegistro(sender: UIStoryboardSegue) {}
    
    @IBAction func searchPaciente(_ sender: UIButton) {
         self.pacientesPicker.reloadAllComponents()
        if DataService.instance.getPacientes().count == 0 {
            print("0")
            return
        }else{
            print("hay")
            DataService.instance.setPacienteInfo(index: index)
            self.pacienteTableview.reloadData()
        }
    
        
    }
    
    
    //UIPicker Protocols
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DataService.instance.getPacientes().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return DataService.instance.getPacientes()[row].nombre
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("algo")
        self.email = DataService.instance.getPacientes()[row].email
        self.index = row
        print(index)
        print(email)
    }
    
    //UItableview Protocols
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getPacienteInfo().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath) as? pacienteCell{
            print(DataService.instance.getPacienteInfo()[indexPath.row])
            cell.setInfo(info: DataService.instance.getPacienteInfo()[indexPath.row])
            return cell
        }
        print("no jalo")
        return UITableViewCell()
    }
    
    

    
    
    
    
    
    
    
}//
