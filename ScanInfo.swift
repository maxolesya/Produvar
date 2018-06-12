//
//  ScanInfo.swift
//  Produvar
//
//  Created by Олеся Максакова on 02.06.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import Foundation

//https://github.com/CepBuch/InteractionWithApi/blob/master/app/src/main/java/produvar/interactionwithapi/model/TagInfoModel.kt

//http://qaru.site/questions/202671/automatic-json-serialization-and-deserialization-of-objects-in-swift - декодирование в объект

class BasicOrderView{
    public var orderCode: String
    public var manufacturer: BasicManufacturerView
    init(orderCode:String, manufacturer: BasicManufacturerView) {
        self.orderCode = orderCode
        self.manufacturer=manufacturer
        
    }
    

    
}

 class BasicManufacturerView{
    public var name:String
    public var  website:String
   
    public var phoneNumber:String
    public var email:String
    init(name:String, website:String,phoneNumber:String,email:String) {
       self.name=name
        self.website = website
        self.phoneNumber=phoneNumber
        self.email=email
    }
    
    /*func containsUsefulData(): Boolean {
        return !name.isNullOrBlank() || !website.isNullOrBlank() ||
            !phoneNumber.isNullOrBlank() || !email.isNullOrBlank()
    }*/
}


    
    class Order{
        public var label:String
        public var code:String
        public var dueDate:String

        public var items:[Orderitem]

        public var process:[Orderprocess]

        public var statusFlow:[Workflowstep]

        init(label:String,code:String,dueDate:String,items:[Orderitem],process:[Orderprocess],statusFlow:[Workflowstep]) {
            self.label=label
            self.code=code
            self.dueDate=dueDate
            self.items=items
            self.statusFlow=statusFlow
            self.process=process
        }
    }

    
    
class Orderitem{
    public var label:String
    init(label:String) {
        self.label=label
            }
}

class Workflowstep{
    public var status:String
    init(status:String) {
        self.status=status
    }
}
class Orderprocess{
    public var label:String
    init(label:String) {
        self.label=label
    }
}



