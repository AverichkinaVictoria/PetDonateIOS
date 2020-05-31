//
//  Pet.swift
//  Pet donate
//
//  Created by Виктория on 29.11.2019.
//  Copyright © 2019 Виктория. All rights reserved.
//

import Foundation
public class Pet {
    public var name:String = ""
    public enum typeOfAnimal {
        case dog,cat
    }
    public enum typeDog {
        case dachhund, poodle
    }
    public enum typeCat {
        case first
    }
    public var typeOfAnimal = Pet.typeOfAnimal.dog
    public var typeCat = Pet.typeCat.first
    public var typeDog = Pet.typeDog.dachhund
}
