//
//  GoogleAuth.swift
//  Pet donate
//
//  Created by Виктория on 12.03.2020.
//  Copyright © 2020 Виктория. All rights reserved.
//

import UIKit
import GoogleSignIn

class GoogleAuth: UIViewController {
    
    @IBAction func shelterCatalog(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CatalogOfShelters") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func catalogPet_pressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "catalogPet") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBOutlet weak var catalogPet_pressed: UIButton!
    @IBOutlet weak var helpValue: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var city: UILabel!
    
    @IBAction func changeProfile(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "changeInfo") as! UIViewController
        self.present(vc, animated: true)
    }
    @IBAction func sign_google(_ sender: Any) {
        
        GIDSignIn.sharedInstance()?.presentingViewController = self

         // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        GIDSignIn.sharedInstance()?.signIn()
        timerSignIn = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.upd), userInfo: nil, repeats: true)

    }
    @IBOutlet weak var signIn_google: UIButton!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    var timerSignIn: Timer!
    
    @IBAction func PetScreen(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! UIViewController
        self.present(vc, animated: true)
    }
    @IBAction func pet(_ sender: Any) {
    let vc = storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! UIViewController
    self.present(vc, animated: true)
}

override func viewDidLoad() {
    super.viewDidLoad()
    
    if (UserDefaults.standard.string(forKey: "userName") != nil && UserDefaults.standard.string(forKey: "userEmail") != nil) {
        userName.text = UserDefaults.standard.string(forKey: "userName")
        userEmail.text = UserDefaults.standard.string(forKey: "userEmail")
    }
    
    if (UserDefaults.standard.string(forKey: "city") != nil) {
        city.text = UserDefaults.standard.string(forKey: "city")
    }
    if (UserDefaults.standard.string(forKey: "phone") != nil) {
        number.text = UserDefaults.standard.string(forKey: "phone")
    }
    if (UserDefaults.standard.integer(forKey: "paidValue") != nil) {
            helpValue.text = "\(UserDefaults.standard.integer(forKey: "paidValue"))" + " переводов"
    }
    
    
    // Do any additional setup after loading the view.
}
    @objc func upd() {
        if (UserDefaults.standard.string(forKey: "userName") != nil && UserDefaults.standard.string(forKey: "userEmail") != nil) {
            userName.text = UserDefaults.standard.string(forKey: "userName")
            userEmail.text = UserDefaults.standard.string(forKey: "userEmail")
            timerSignIn?.invalidate()
            timerSignIn = nil
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
