//
//  AdoptForm.swift
//  Pet donate
//
//  Created by Виктория on 06.05.2020.
//  Copyright © 2020 Виктория. All rights reserved.
//

import Foundation
public class AdoptForm: Codable{
    public var shelter_id:CLong  = 0
    public var animal_id:CLong  = 0
    public var name: String = ""
    public var Phone: String = ""
    public var email: String = ""
    
    init(shelter_id: CLong, animal_id: CLong, name: String, phone: String, email: String)  {
        self.shelter_id = shelter_id
        self.name = name
        Phone = phone
        self.email = email
    }
    
}
