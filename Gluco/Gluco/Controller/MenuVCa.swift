//
//  MenuVC.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/15/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit
import Firebase

class MenuVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Outlets
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        self.revealViewController().rearViewRevealWidth = (self.view.frame.size.width - 150)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func profileBtn(_ sender: Any) {
    
        if(variables.userType == "paciente"){//paciente
           let showProfile = UserProfileVC()
            showProfile.modalPresentationStyle = .custom
            present(showProfile, animated: true)
            
        }else if(variables.userType == "doctor"){
           let showProfile = DoctorProfile()
            showProfile.modalPresentationStyle = .custom
            present(showProfile, animated: true)
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(variables.userType == "paciente"){//paciente
            return DataService.instance.getUserMenu().count
        }else if(variables.userType == "doctor"){
            return DataService.instance.getDoctorMenu().count
        }else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? menuCell{
            if(variables.userType == "paciente"){//Paciente
                let menu = DataService.instance.getUserMenu()[indexPath.row]
                cell.updateMenu(Menu: menu)
                cell.layer.backgroundColor = UIColor.clear.cgColor
                
            }else if(variables.userType == "doctor"){
                let menu = DataService.instance.getDoctorMenu()[indexPath.row]
                cell.updateMenu(Menu: menu)
                cell.layer.backgroundColor = UIColor.clear.cgColor
            }
            cell.backgroundColor = UIColor.clear
            return cell
        }else {
            return menuCell()
        }
    }///
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = [menu]()
        if (variables.userType == "paciente") {
            item = DataService.instance.getUserMenu()
        }else{
            item = DataService.instance.getDoctorMenu()
        }
        
        let selectedItem = item[indexPath.row]
        
        
        switch selectedItem.menuTitle {
        case "Consultas":
            print("consulta")
            self.performSegue(withIdentifier: "ConsultasSegue", sender: self)
            break
        case "Dietas":
            print("dieta")
            self.performSegue(withIdentifier: "DietasSegue", sender: self)
            break
        case "Registrar paciente":
            print("registrar")
            self.performSegue(withIdentifier: "RegistrarSegure", sender: self)
            break
        case "Medición":
            print("medicion")
            self.performSegue(withIdentifier: "MedicionesSegue", sender: self)
            break
        case "Doctor":
            print("doc")
            self.performSegue(withIdentifier: "DietasSegue", sender: self)
            break
        default:
            print("")
        }
        
    }
    
    @IBAction func test(_ sender: Any) {
          DataService.instance.getPaccientesFromFB()
       //print(DataService.instance.getPacientes())
        //print(DataService.instance.getUserMenu())
    }
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        try! Auth.auth().signOut()
        self.performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
}
