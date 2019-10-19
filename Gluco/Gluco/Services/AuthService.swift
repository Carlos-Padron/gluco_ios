//
//  AuthService.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/30/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import Foundation
import Firebase


class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggin: Bool{
        get{
            return defaults.bool(forKey: "loggedIn")
        }
        set{
            defaults.set(newValue, forKey: "loggedIn")
        }
    }
    
    var isDoctor: Bool{
        get{
            return defaults.bool(forKey: "user")
        }
        set{
            defaults.set(newValue, forKey: "user")
        }
    }
    
    var userEmail: String{
        get{
            return defaults.value(forKey: "userEmail") as! String
        }
        set{
            defaults.set(newValue, forKey: "userEmail")
        }
    }
    
    
    
    func errorHandler (error: NSError) -> String{
        
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            switch(errorCode){
            case .emailAlreadyInUse:
                print("en uso")
                return  "usedEmail"
              //  break
            case .userNotFound:
                print("no existe")
                return  "userNotExists"
                //break
            case .wrongPassword :
                print("mala ps")
                return  "wrongPW"
                //break
            case .weakPassword:
                print("ps fea")
                return "weakPW"
               // break
            default :
                print("error")
                print("error, intentar mas tarde")
                return "error"
                //break
            }
        }
    return ""
    }
    
    
}
