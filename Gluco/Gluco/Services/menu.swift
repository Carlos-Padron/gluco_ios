//
//  menu.swift
//  Gluco
//
//  Created by Carlos Padrón on 9/19/19.
//  Copyright © 2019 Carlos Padrón. All rights reserved.
//

import Foundation

struct menu {
    public private(set) var menuTitle: String
    public private(set) var menuIcon: String
    
    init(menuTitle:String, menuIcon:String) {
        self.menuTitle = menuTitle
        self.menuIcon = menuIcon
    }
}
