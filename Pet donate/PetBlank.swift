//
//  PetBlank.swift
//  Pet donate
//
//  Created by Виктория on 06.05.2020.
//  Copyright © 2020 Виктория. All rights reserved.
//

import UIKit

class PetBlank: UIViewController {
    @IBAction func confirm_pressed(_ sender: Any) {
        log.debug("Confirm pet blank was pressed")
        
        if ( emailUser.text != nil && emailUser.text != "" && phoneNumber.text != nil && phoneNumber.text != "" && nameUser.text != nil  && nameUser.text != "" ) {
            bottomLinePhone.backgroundColor = CGColor (srgbRed: 0, green: 0, blue: 0, alpha: 1)
            bottomLineEmail.backgroundColor = CGColor (srgbRed: 0, green: 0, blue: 0, alpha: 1)
            bottomLineName.backgroundColor = CGColor (srgbRed: 0, green: 0, blue: 0, alpha: 1)
            getReqAndNesInfo(n: UserDefaults.standard.integer(forKey: "n"))
            log.info("Correct pet blank info")
            let vc = storyboard?.instantiateViewController(withIdentifier: "thankYouSc") as! UIViewController
            self.present(vc, animated: true)

        } else {
            log.warning("Incorrect info of pet blank")
            displayIncorrect()
        }
            }
    @IBOutlet weak var commentUser: UIImageView!
    
    @IBOutlet weak var emailUser: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var nameUser: UITextField!
    
    @IBOutlet weak var shelterName: UILabel!
    
    @IBAction func back_pressed(_ sender: Any) {
        log.debug("Back button was pressed")
        let vc = storyboard?.instantiateViewController(withIdentifier: "petCard") as! UIViewController
        self.present(vc, animated: true)
    
    }
    
    var bottomLineName = CALayer()
    var bottomLinePhone = CALayer()
    var bottomLineEmail = CALayer()
    override func viewDidLoad() {
        log.debug("Pet blank was loaded")
        super.viewDidLoad()
        getReq(n: UserDefaults.standard.integer(forKey: "n_pet"))

        bottomLineName.frame = CGRect(x: (CGFloat)(nameUser.bounds.minX), y: nameUser.frame.height - 1, width: (CGFloat)(0.45 * UIScreen.main.bounds.maxX), height: 1.0)
         bottomLineName.backgroundColor = CGColor (srgbRed: 0, green: 0, blue: 0, alpha: 1)
         nameUser.borderStyle = UITextField.BorderStyle.none
         nameUser.layer.addSublayer(bottomLineName)
        
        bottomLinePhone.frame = CGRect(x: (CGFloat)(phoneNumber.bounds.minX), y: phoneNumber.frame.height - 1, width: (CGFloat)(0.45 * UIScreen.main.bounds.maxX), height: 1.0)
         bottomLinePhone.backgroundColor = CGColor (srgbRed: 0, green: 0, blue: 0, alpha: 1)
         phoneNumber.borderStyle = UITextField.BorderStyle.none
         phoneNumber.layer.addSublayer(bottomLinePhone)
        
        bottomLineEmail.frame = CGRect(x: (CGFloat)(emailUser.bounds.minX), y: emailUser.frame.height - 1, width: (CGFloat)(0.45 * UIScreen.main.bounds.maxX), height: 1.0)
         bottomLineEmail.backgroundColor = CGColor (srgbRed: 0, green: 0, blue: 0, alpha: 1)
         emailUser.borderStyle = UITextField.BorderStyle.none
         emailUser.layer.addSublayer(bottomLineEmail)
        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func keyboardWillHide()
    {
        self.view.frame.origin.y = 0
    }

    @objc func keyboardWillChange(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        {
            
        }
    }
    
    func getReq(n:Int) {

        
        let http: HTTPCommunication = HTTPCommunication()
        // checking if the url is valid
        let url: URL = URL(string: "https://demopet.herokuapp.com//apiv1/animals/")!

        http.retrieveURL(url) {
            // To avoid capturing self in the closure, make weak self
            [weak self] (data) -> Void in
            
            // Getting and printing a JSON string representation
            // data to know what format to translate it to. If
            // we can't get a normal json from the loaded data,
            // then we don't go any further.
            guard let json = String(data: data, encoding: String.Encoding.utf8) else { return }
            print("JSON: ", json)
                
            do {
                let jsonObject: [Animal] = try! JSONDecoder().decode([Animal].self, from: data)
                self?.getReqShelter(s: jsonObject[n].shelter_id)
            } catch {
                print("Can't serialize data.")
            }
        }
    }

    
    func getReqAndNesInfo(n:Int) {
        let http: HTTPCommunication = HTTPCommunication()
        let url: URL = URL(string: "https://demopet.herokuapp.com//apiv1/animals/")!

        http.retrieveURL(url) {
            [weak self] (data) -> Void in
            guard let json = String(data: data, encoding: String.Encoding.utf8) else { return }
            print("JSON: ", json)
                
            do {
                let jsonObject: [Animal] = try! JSONDecoder().decode([Animal].self, from: data)
                
                let adopt = AdoptForm(shelter_id: jsonObject[n].shelter_id, animal_id: jsonObject[n].id, name: (self?.nameUser.text)!, phone: (self?.phoneNumber.text)!, email: (self?.emailUser.text)!)
                var jsnHelp: Data = try! JSONEncoder().encode(adopt)
                self?.postReq(info: jsnHelp)
            } catch {
                print("Can't serialize data.")
            }
        }
    }
    
    
    
    func  postReq(info: Data)
        {
            let url = URL(string: "https://demopet.herokuapp.com//apiv1/help")
            guard let requestUrl = url else { fatalError() }
            // Prepare URL Request Object
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "POST"
             
            // HTTP Request Parameters which will be sent in HTTP Request Body
            // Set HTTP Request Body
            request.httpBody = info
            // Perform HTTP Request
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    // Check for Error
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    // Convert HTTP Response Data to a String
              // let jsonObject: HelpForm = try! JSONDecoder().decode(HelpForm.self, from: data!)
           //     print (jsonObject)
            }
            task.resume()
        }
    
    func displayIncorrect()
    {
        if (phoneNumber.text == nil || phoneNumber.text == "") {
              bottomLinePhone.backgroundColor = CGColor (srgbRed: 1, green: 0, blue: 0, alpha: 1)
        }
        if (emailUser.text == nil || emailUser.text == ""){
              bottomLineEmail.backgroundColor = CGColor (srgbRed: 1, green: 0, blue: 0, alpha: 1)
        }
        if (nameUser.text == nil || nameUser.text == ""){
              bottomLineName.backgroundColor = CGColor (srgbRed: 1, green: 0, blue: 0, alpha: 1)
        }
    }
    
    func getReqShelter(s:CLong) {

        
        let http: HTTPCommunication = HTTPCommunication()
        let url: URL = URL(string: "https://demopet.herokuapp.com/apiv1/shelter/"+"\(s)"+"/1")!

        http.retrieveURL(url) {
            [weak self] (data) -> Void in
            guard let json = String(data: data, encoding: String.Encoding.utf8) else { return }
            print("JSON: ", json)
                
            do {
                let jsonObject: Shelter = try! JSONDecoder().decode(Shelter.self, from: data)
                
                self?.shelterName.text = jsonObject.name
            } catch {
                print("Can't serialize data.")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
