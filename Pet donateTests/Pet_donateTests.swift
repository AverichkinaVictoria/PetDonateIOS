//
//  Pet_donateTests.swift
//  Pet donateTests
//
//  Created by Виктория on 31.05.2020.
//  Copyright © 2020 Виктория. All rights reserved.
//

import XCTest
@testable import Pet_donate

class Pet_donateTests: XCTestCase {

    override func setUpWithError() throws {
        print ("The start of testing")
    }

    override func tearDownWithError() throws {
        print ("The end of testing")
    }

        func testPetClass1() throws {
            var petTest: Pet = Pet()
            petTest.name = "Micke"
            XCTAssertEqual(petTest.name, "Micke", "Name initialization is wrong")
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct results.
        }

    func testAnimal() throws {
        var animal: Animal = Animal()
        animal.id = 1234
        animal.shelter_id = 454
        animal.name = ""
        animal.gender = "boy"
        XCTAssertEqual( animal.id, 1234, "ID initialization is wrong")
        XCTAssertEqual( animal.shelter_id, 454, "ID_shelter initialization is wrong")
        XCTAssertEqual( animal.name, "", "Name initialization is wrong")
        XCTAssertEqual( animal.gender, "boy", "ID initialization is wrong")
    }
    
    func testHelpForm() throws {

        var form: HelpForm = HelpForm(shelter_id: 123, name: "Vicky", phone: "98571829384", email: "ake@mail.ru", date: "22.3.20", extra: "no info")
        XCTAssertEqual( form.shelter_id, 123, "ID_Shelter initialization is wrong")
        XCTAssertEqual( form.name, "Vicky", "Name initialization is wrong")
        XCTAssertEqual( form.Phone, "98571829384", "Phone initialization is wrong")
        XCTAssertEqual( form.email, "ake@mail.ru", "Email initialization is wrong")
        XCTAssertEqual( form.date, "22.3.20", "Date initialization is wrong")
        XCTAssertEqual( form.extra, "no info", "Extra initialization is wrong")
    
    }
    
    func testAdoptForm() throws {

        var form: AdoptForm = AdoptForm(shelter_id: 123, animal_id: 22, name: "Vick", phone: "939200293888", email: "fifo@mail.ru")
        XCTAssertEqual( form.shelter_id, 123, "ID_Shelter initialization is wrong")
        XCTAssertEqual( form.name, "Vick", "Name initialization is wrong")
        XCTAssertEqual( form.Phone, "939200293888", "Phone initialization is wrong")
        XCTAssertEqual( form.email, "fifo@mail.ru", "Email initialization is wrong")
    
    }

    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
