//
//  ChangePet.swift
//  Pet donate
//
//  Created by Виктория on 03.05.2020.
//  Copyright © 2020 Виктория. All rights reserved.
//

import UIKit

class ChangePet: UIViewController {
    @IBAction func no_pressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! UIViewController
               self.present(vc, animated: true)
    }
    @IBAction func yes_pressed(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "type")
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "food")
        UserDefaults.standard.removeObject( forKey: "fun")
        UserDefaults.standard.removeObject( forKey: "health")
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "first") as! UIViewController
               self.present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
