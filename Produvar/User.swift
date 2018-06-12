//
//  User.swift
//  Produvar
//
//  Created by Олеся Максакова on 29.05.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import Foundation
class User  {//он публичный или нет
    public var role:String
    public var name: String
    public var bearer: String
    public var username:String
    init(role:String,name: String,bearer: String,username:String) {
        self.name = name
        self.role=role
        self.bearer=bearer
        self.username = username
    
    }

}

