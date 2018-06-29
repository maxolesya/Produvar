//
//  User.swift
//  Produvar
//
//  Created by Олеся Максакова on 29.05.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import Foundation
class User:Decodable  {//он публичный или нет
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
class Manufacturer  {//он публичный или нет
    public var website:String
    public var name: String
    public var phonenumber: String
    public var email:String
    init(website:String,name: String,phonenumber: String,email:String) {
        self.name = name
        self.website=website
        self.phonenumber=phonenumber
        self.email = email
        
    }
    
}


