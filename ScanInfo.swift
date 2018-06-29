//
//  ScanInfo.swift
//  Produvar
//
//  Created by Олеся Максакова on 02.06.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import Foundation
import Alamofire

//https://github.com/CepBuch/InteractionWithApi/blob/master/app/src/main/java/produvar/interactionwithapi/model/TagInfoModel.kt

//http://qaru.site/questions/202671/automatic-json-serialization-and-deserialization-of-objects-in-swift - декодирование в объект

class BasicOrderView:Decodable{
    public var orderCode: String
    public var manufacturer: BasicManufacturerView
    init(orderCode:String, manufacturer: BasicManufacturerView) {
        self.orderCode = orderCode
        self.manufacturer=manufacturer
        
    }
    

    
}

 class BasicManufacturerView:Decodable{
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


    
    class Order:Decodable{
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
        func count() -> [Int:String] {
            var index:Int = 1
            var dict:[Int:String] = [:]
            if dueDate.count != 0 {
                dict[index] = "dueDate"
                index = index+1
            }
          
            if items.count != 0 {
                dict[index] = "items"
                index = index+1
            }
            if statusFlow.count != 0 {
                dict[index] = "statusFlow"
                index = index+1
                for item in statusFlow {
                    if item.iscurrent == "false" && item.isfinished == "false" {
                        
                        dict[index] = "update"
                        index = index+1
                        break
                    }
                }
            }
            if process.count != 0 {
                dict[index] = "process"
                index = index+1
            }
            
          
            return dict
        }
    }

    
    
class Orderitem:Decodable{
    public var label:String
    init(label:String) {
        self.label=label
            }
}

class Workflowstep:Decodable{
    public var status:String
    public var iscurrent:String
    public var isfinished:String
    init(status:String,iscurrent:String,isfinished:String) {
        self.status=status
        self.iscurrent=iscurrent
        self.isfinished=isfinished
    }
}
class Orderprocess:Decodable{
    public var label:String
    public var when:String
    public var description:String
    
    init(label:String, when:String,description:String) {
        self.label=label
        self.when = when
        self.description = description
    }
}



