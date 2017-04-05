//
//  Database_Handler.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/3/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import Foundation
import Alamofire

class DataHandler {
    
    init() {
        
    }
    
    
    public func createUser(with fname: String, lname: String, sex: String, weight: String, height: String, dob: String, smoke: String, username: String, password: String, email: String) -> Bool{
        
        let URL_USER_REGISTER = "http://www.lukeporupski.com/register.php"

        
        let params: Parameters = [
            "username":username,
            "password":password,
            "email":email,
            "first_name":fname,
            "last_name":lname
        
        ]
        
        //Sending http post request
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: params).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    
                    //displaying the message in label
                    let x = 5
                    //self.labelMessage.text = jsonData.value(forKey: "message") as! String?
                }
        }
        
        return true
    }
    
}
