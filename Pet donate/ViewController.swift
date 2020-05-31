//
//  ViewController.swift
//  Pet donate
//
//  Created by Виктория on 28.11.2019.
//  Copyright © 2019 Виктория. All rights reserved.
//

import UIKit

var petChange:Int = 0
var nameOfPet:String = ""

class ViewController: UIViewController {
    
    @IBOutlet weak var bttnChoose: UIButton!
    @IBOutlet weak var petName: UITextField!
    @IBOutlet weak var petType: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var petPicture: UIImageView!
    
    @IBAction func choose_press(_ sender: Any){
        log.info("Choose button pressed")

        let myPet = Pet()
        myPet.name = petName.text!
       if(!(myPet.name != "" && myPet.name.count >= 2 && myPet.name.count <= 8)) {
            bottomLine.backgroundColor = CGColor (srgbRed: 1, green: 0, blue: 0, alpha: 1)
            petName.text = ""
            petName.placeholder = "Неверно введено имя"
        log.info("Wrong name initialization")
        } else {
             bottomLine.backgroundColor = CGColor (srgbRed: 0, green: 0, blue: 0, alpha: 1)
            if(petChange == 0) {
                myPet.typeOfAnimal = Pet.typeOfAnimal.dog
            } else if (petChange == 1) {
                myPet.typeOfAnimal = Pet.typeOfAnimal.cat
            }
            
            if(myPet.name != "" && myPet.name.count >= 2 && myPet.name.count <= 8) {
                UserDefaults.standard.set(myPet.name, forKey: "name")
                log.info("Pet name was saved")
                let vc = storyboard?.instantiateViewController(withIdentifier: "ChooseType") as! UIViewController
                    self.present(vc, animated: true)
            }
        }
    }
   
    @IBAction func left_press(_ sender: Any) {
        log.info("Left click")
        if(petChange == 0) {
            petPicture.image = UIImage(named: "cat picture")
            petType.text = "Кошка"
            petChange = 1
        } else if(petChange == 1) {
            petPicture.image = UIImage(named: "dog picture")
            petType.text = "Собака"
            petChange = 0
        }
    }
    
    @IBAction func right_press(_ sender: Any) {
        log.info("Right click")
        if(petChange == 0) {
            petPicture.image = UIImage(named: "cat picture")
            petType.text = "Кошка"
            petChange = 1
        } else if(petChange == 1) {
            petPicture.image = UIImage(named: "dog picture")
             petType.text = "Собака"
            petChange = 0
        }
    }
    var bottomLine = CALayer()

    override func viewDidLoad() {
        log.info("Screen of choosing pet type was loaded")
        
        super.viewDidLoad()
        DispatchQueue.main.async {
           // nameField.text = "i'm here"
            if ((UserDefaults.standard.string(forKey: "type") != nil) && (UserDefaults.standard.string(forKey: "name") != nil)) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! UIViewController
            self.present(vc, animated: false)
            }
        }
       
        bottomLine.frame = CGRect(x: (CGFloat)(0.1 * UIScreen.main.bounds.maxX), y: nameField.frame.height - 1, width: (CGFloat)(0.7 * UIScreen.main.bounds.maxX), height: 1.0)
        bottomLine.backgroundColor = CGColor (srgbRed: 0, green: 0, blue: 0, alpha: 1)
        nameField.borderStyle = UITextField.BorderStyle.none
        nameField.layer.addSublayer(bottomLine)
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    

    @objc func dismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func keyboardWillHide(){
        self.view.frame.origin.y = 0
    }

    @objc func keyboardWillChange(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if nameField.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height
            }
        }
    }
}

