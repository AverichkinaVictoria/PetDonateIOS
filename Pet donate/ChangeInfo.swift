//
//  ChangeInfo.swift
//  Pet donate
//
//  Created by Виктория on 04.05.2020.
//  Copyright © 2020 Виктория. All rights reserved.
//

import UIKit
import GoogleSignIn

class ChangeInfo: UIViewController {
    
    @IBAction func confirmChanges(_ sender: Any) {
        if (phone.text != nil && phone.text != ""){
            UserDefaults.standard.set(phone.text, forKey: "phone")
        }
        if (city.text != nil && city.text != "") {
            UserDefaults.standard.set(city.text, forKey: "city")
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "GoogleView") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func signOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "ID")
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "userName")
        let vc = storyboard?.instantiateViewController(withIdentifier: "GoogleView") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var city: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: (CGFloat)(city.bounds.minX), y: city.frame.height - 1, width: (CGFloat)(0.7 * UIScreen.main.bounds.maxX), height: 1.0)
         bottomLine.backgroundColor = CGColor (srgbRed: 0, green: 0, blue: 0, alpha: 1)
         city.borderStyle = UITextField.BorderStyle.none
         city.layer.addSublayer(bottomLine)
        
        var bottomLine1 = CALayer()
                bottomLine1.frame = CGRect(x: (CGFloat)(phone.bounds.minX), y: phone.frame.height - 1, width: (CGFloat)(0.7 * UIScreen.main.bounds.maxX), height: 1.0)
                bottomLine1.backgroundColor = CGColor (srgbRed: 0, green: 0, blue: 0, alpha: 1)
                phone.borderStyle = UITextField.BorderStyle.none
                phone.layer.addSublayer(bottomLine1)
        
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
         
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
         
         view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }

    @objc func keyboardWillChange(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
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
