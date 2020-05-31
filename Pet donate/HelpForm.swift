//
//  HelpForm.swift
//  Pet donate
//
//  Created by Виктория on 06.05.2020.
//  Copyright © 2020 Виктория. All rights reserved.
//

import Foundation
public class HelpForm: Codable{
    public var shelter_id:CLong  = 0
    public var name: String = ""
    public var Phone: String = ""
    public var email: String = ""
    public var date: String = ""
    public var extra: String = ""
    
    init(shelter_id: CLong, name: String, phone: String, email: String, date: String, extra: String) {
        self.shelter_id = shelter_id
        self.name = name
        Phone = phone
        self.email = email
        self.date = date
        self.extra = extra
    }
    
}
