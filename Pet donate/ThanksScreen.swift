//
//  ThanksScreen.swift
//  Pet donate
//
//  Created by Виктория on 06.05.2020.
//  Copyright © 2020 Виктория. All rights reserved.
//

import UIKit

class ThanksScreen: UIViewController {

    @IBAction func ok_pressed(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "n_pet")
        UserDefaults.standard.removeObject(forKey: "n")
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! UIViewController
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
