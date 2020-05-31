//
//  PetCatalog.swift
//  Pet donate
//
//  Created by Виктория on 04.05.2020.
//  Copyright © 2020 Виктория. All rights reserved.
//

import UIKit

class PetCatalog: UIViewController {
    @IBAction func left_click(_ sender: Any) {
        n -= 1
               if (n == 0) {
                   leftBttn.isHidden = true
               } else {
                   leftBttn.isHidden = false
               }
               rightBttn.isHidden = false
               getReq(n: n)
    }
    
    @IBAction func right_click(_ sender: Any) {
        n += 1
               if (n == 0){
                   leftBttn.isHidden = true
               } else {
                   leftBttn.isHidden = false
               }
               rightBttn.isHidden = false
               getReq(n: n)
    }
    
    @IBAction func shelterCatalog(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "n_pet")
        let vc = storyboard?.instantiateViewController(withIdentifier: "CatalogOfShelters") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBOutlet weak var rightBttn: UIButton!
    @IBOutlet weak var leftBttn: UIButton!
    @IBOutlet weak var petAgeCity: UILabel!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petSex: UIImageView!
    @IBOutlet weak var petPicture: UIImageView!
    
    @IBAction func moreInfo_pressed(_ sender: Any) {
        UserDefaults.standard.set(n, forKey: "n_pet")
        let vc = storyboard?.instantiateViewController(withIdentifier: "petCard") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func petScreen_pressed(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "n_pet")
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! UIViewController
               self.present(vc, animated: true)
    }
    
    @IBAction func accountInfo_pressed(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "n_pet")
        let vc = storyboard?.instantiateViewController(withIdentifier: "GoogleView") as! UIViewController
        self.present(vc, animated: true)
    }
    
    var n: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       if (UserDefaults.standard.integer(forKey: "n_pet") != nil) {
           n = UserDefaults.standard.integer(forKey: "n_pet")
       }
       if (n == 0) {
           leftBttn.isHidden = true
       }
       rightBttn.isHidden = false
       getReq(n: n)
        
    }
    
    func getReq(n:Int) {

        
        let http: HTTPCommunication = HTTPCommunication()
        let url: URL = URL(string: "https://demopet.herokuapp.com//apiv1/animals/")!

        http.retrieveURL(url) {
            [weak self] (data) -> Void in
            guard let json = String(data: data, encoding: String.Encoding.utf8) else { return }
            print("JSON: ", json)
                
            do {
                let jsonObject: [Animal] = try! JSONDecoder().decode([Animal].self, from: data)
                if (n + 1 == jsonObject.count) {
                    self?.rightBttn.isHidden = true
                }
                print (jsonObject.count)
                print (n)
                self?.petPicture.image = UIImage(named: "animal_test_"+"\(n)")
                
                self?.petName.text = jsonObject[n].name
                if (jsonObject[n].gender == "Мальчик") {
                    self?.petSex.image = UIImage(named: "boy_petCard")
                } else{
                    self?.petSex.image = UIImage(named: "girl_petCard")
                }
                self?.petAgeCity.text = jsonObject[n].type
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
