//
//  DietasVCViewController.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/22/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import UIKit
import Firebase

class DietasVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate {


    
    //Outlets
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var addDieta: UIButton!
    @IBOutlet weak var pacientePicker: UIPickerView!
    @IBOutlet weak var dieta1Tableview: UITableView!
    @IBOutlet weak var dieta2Tableview: UITableView!
    @IBOutlet weak var dieta3Tableview: UITableView!
    
    //Variable
    var email:String!
    var dietaCount: Int!
    var observer: NSObjectProtocol?
   // private var docRef: DocumentReference? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(DataService.instance.getDieta1())
        setUpSWReveal()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         NotificationCenter.default.addObserver(self, selector: #selector(DietasVC.reload), name: NSNotification.Name("reload"), object: nil)
        observer = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "agrego"), object: UIApplication.shared, queue: OperationQueue.main, using: { (Notification) in
            print("jalo")
            self.reload()
        })

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "reload"), object: nil)
        if let _ = observer{
            NotificationCenter.default.removeObserver(observer!)
        }
    }
    
    

    
    func setUpSWReveal(){
        menuBtn.target = self.revealViewController()
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    @IBAction func addPressed(_ sender: Any) {
        if DataService.instance.getPacientes().count == 0 {
            let alert = UIAlertController(title: "No hay pacientes", message: "Para continuar por favor agregar pacientes", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style:.default ))
            return
        }else{
            if self.email == nil {self.email = DataService.instance.getPacientes()[0].email}
            buscarDietas(email: email)
            agregarDietas()
        }

    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        if DataService.instance.getPacientes().count == 0 {
            let alert = UIAlertController(title: "No hay pacientes", message: "Para continuar por favor agregar pacientes", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style:.default ))
            return
        }else{
            if self.email == nil {self.email = DataService.instance.getPacientes()[0].email}
            print(email)
            buscarDietas(email: email)
        }

        
    }
    func agregarDietas(){
        
        if self.email == nil {self.email = DataService.instance.getPacientes()[0].email}
        print(email)
        Firestore.firestore().collection("dietas").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error{
                print("error al traer docs")
            }else{
                if self.email == nil {self.email = DataService.instance.getPacientes()[0].email}
                self.dietaCount = querySnapshot!.count as Int
                print(self.dietaCount)
                print(self.email!)
                
                    if self.dietaCount < 3{
                        let modalDietas = AddDietas()
                        modalDietas.email = self.email
                        modalDietas.modalPresentationStyle = .custom
                        self.present(modalDietas, animated: true)
                    }else{
                        let alert = UIAlertController(title: "Límite alcanzado", message: "Se alcanzó el límite de dietas. Para agregar otra elimine una.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
    }
    
    func buscarDietas(email:String){
        DataService.instance.fillDieta1(email: email)
         DataService.instance.fillDieta2(email: email)
         DataService.instance.fillDieta3(email: email)
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
        print(email)
    }
    

    //UITableView Protocols
    
    func setUpTables(){
        self.dieta1Tableview.dataSource = self
        self.dieta1Tableview.delegate = self
        self.dieta2Tableview.dataSource = self
        self.dieta2Tableview.delegate = self
        self.dieta3Tableview.dataSource = self
        self.dieta3Tableview.delegate = self
        
        self.dieta1Tableview.rowHeight = UITableView.automaticDimension
        self.dieta2Tableview.rowHeight = UITableView.automaticDimension
        self.dieta3Tableview.rowHeight = UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == dieta1Tableview{
                return DataService.instance.getDieta1().count
        }
        if tableView == dieta2Tableview{
                return DataService.instance.getDieta2().count
        }
        if tableView == dieta3Tableview{
                return DataService.instance.getDieta3().count
        }
        return 0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.dieta1Tableview{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "content", for: indexPath) as? dietasCell{
                let dieta1Content = DataService.instance.getDieta1()
                if dieta1Content.count != 0 {
                    print(DataService.instance.getTipoComida())
                        let comida = DataService.instance.getTipoComida()[indexPath.row]
                        cell.fillTable(tipoComida: comida , descripcion:dieta1Content[indexPath.row] )
                        return cell
                }

            }
        }
        else if tableView == dieta2Tableview{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "content", for: indexPath) as? dietasCell{
                let dieta2Content = DataService.instance.getDieta2()
                if dieta2Content.count != 0 {
                    let comida = DataService.instance.getTipoComida()[indexPath.row]
                    cell.fillTable(tipoComida: comida , descripcion:dieta2Content[indexPath.row] )
                    return cell
                }
            }
        }
        else if tableView == dieta3Tableview{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "content", for: indexPath) as? dietasCell{
                print("cantidad en dieta 3 \(DataService.instance.getDieta3().count)")
                let dieta3Content = DataService.instance.getDieta3()
                if dieta3Content.count != 0 {
                    print(indexPath.row)
                    let comida = DataService.instance.getTipoComida()[indexPath.row]
                    cell.fillTable(tipoComida: comida , descripcion:dieta3Content[indexPath.row] )
                    return cell
                }
            }
        }
       
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == self.dieta1Tableview{
            if DataService.instance.getNombreDieta1() != ""{
                if let header = tableView.dequeueReusableCell(withIdentifier: "header") as? dietasCell{
                    header.setHeader(nombreDieta: DataService.instance.getNombreDieta1())
                    return header
                }
            }
        }
        else if tableView == dieta2Tableview{
            if DataService.instance.getNombreDieta2() != "" {
                if let header = tableView.dequeueReusableCell(withIdentifier: "header") as? dietasCell{
                        header.setHeader(nombreDieta: DataService.instance.getNombreDieta2())
                        return header
                }
            }
           
        }
        else if tableView == dieta3Tableview{
            if DataService.instance.getNombreDieta3() != "" {
                if let header = tableView.dequeueReusableCell(withIdentifier: "header") as? dietasCell{
                    header.setHeader(nombreDieta: DataService.instance.getNombreDieta3())
                    return header
                }
            }
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
    
    
    //Notifications

    @objc func reload(){
        self.dieta1Tableview.reloadData()
        self.dieta2Tableview.reloadData()
        self.dieta3Tableview.reloadData()
        print("recargado")
    }
}//



    

