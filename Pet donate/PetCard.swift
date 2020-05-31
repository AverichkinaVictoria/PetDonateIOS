//
//  PetCard.swift
//  Pet donate
//
//  Created by Виктория on 05.05.2020.
//  Copyright © 2020 Виктория. All rights reserved.
//

import UIKit

class PetCard: UIViewController {
    @IBOutlet weak var petPicture: UIImageView!
    @IBAction func confirm_pressed(_ sender: Any) {
        log.debug("Confirm visit was pressed")
        let vc = storyboard?.instantiateViewController(withIdentifier: "petAdopt") as! UIViewController
        self.present(vc, animated: true)
    }
    @IBOutlet weak var petAppearance: UILabel!
    @IBOutlet weak var petCharacter: UILabel!
    @IBOutlet weak var petShelterName: UILabel!
    @IBOutlet weak var petSex: UIImageView!
    @IBOutlet weak var petName: UILabel!
    
    @IBAction func shelterCatalog(_ sender: Any) {
        log.debug("Shelter catalog was pressed")
        let vc = storyboard?.instantiateViewController(withIdentifier: "CatalogOfShelters") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func back_pressed(_ sender: Any) {
        log.debug("Back button was pressed")
        let vc = storyboard?.instantiateViewController(withIdentifier: "catalogPet") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func accountInfo_pressed(_ sender: Any) {
        log.debug("Account info was pressed")
        let vc = storyboard?.instantiateViewController(withIdentifier: "GoogleView") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func petScreen(_ sender: Any) {
        log.debug("Main screen was pressed")
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBOutlet weak var petScreen_pressed: UIButton!
    override func viewDidLoad() {
        log.debug("Pet card was loaded")
        super.viewDidLoad()
        getReq(n: UserDefaults.standard.integer(forKey: "n_pet"))

        // Do any additional setup after loading the view.
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
                self?.getReqShelter(s: jsonObject[n].shelter_id)
                self?.petName.text = jsonObject[n].name
                self?.petCharacter.text = jsonObject[n].behavior
                self?.petAppearance.text = jsonObject[n].appear
                self?.petPicture.image = UIImage(named: "animal_test_"+"\(n)")
                if (jsonObject[n].gender == "Мальчик")   {
                    self?.petSex.image = UIImage(named: "boy_petCard")
                } else  {
                    self?.petSex.image = UIImage(named: "girl_petCard")
                }
              
            } catch {
                print("Can't serialize data.")
            }
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
                
                self?.petShelterName.text = jsonObject.name
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
