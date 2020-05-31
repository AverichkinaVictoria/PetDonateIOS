//
//  ShelterCard.swift
//  Pet donate
//
//  Created by Виктория on 06.05.2020.
//  Copyright © 2020 Виктория. All rights reserved.
//

import UIKit

class ShelterCard: UIViewController {
    @IBOutlet weak var shelterPhone: UILabel!
    @IBOutlet weak var shelterMail: UILabel!
    @IBOutlet weak var shelterUrl: UILabel!
    @IBOutlet weak var shelterLocation: UILabel!
    @IBOutlet weak var shelterName: UILabel!
    @IBOutlet weak var shelterPicture: UIImageView!
    @IBAction func confirm_pressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "shelterVisit") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func back_pressed(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "search")
        let vc = storyboard?.instantiateViewController(withIdentifier: "CatalogOfShelters") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func accountInfo(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "search")
        UserDefaults.standard.removeObject(forKey: "n")
        let vc = storyboard?.instantiateViewController(withIdentifier: "GoogleView") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func petCatalog(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "search")
        UserDefaults.standard.removeObject(forKey: "n")
        let vc = storyboard?.instantiateViewController(withIdentifier: "catalogPet") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func petScreen(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "search")
        UserDefaults.standard.removeObject(forKey: "n")
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! UIViewController
                      self.present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (UserDefaults.standard.bool(forKey: "search") != nil && UserDefaults.standard.bool(forKey: "search") == true) {
            getReqForSearch(strSearch: UserDefaults.standard.string(forKey: "sheltSearch")!)
        } else {
            getReq(n: UserDefaults.standard.integer(forKey: "n"))
        }

        // Do any additional setup after loading the view.
    }
    
    func Wagner_Fischer_for_Damerau_Levenshtein(str1: String, str2:String) -> Int{
           var len_s:Int = str1.count
           var len_t:Int = str2.count
           var s = Array(str1)
           var t = Array(str2)
           var arr = [[Int]]()
           for _ in 0..<len_s {
               var subArray = [Int]()
               for _ in 0..<len_t {
                   subArray.append(0)
               }
               arr.append(subArray)
           }
           
           for i in 0..<len_s {
               arr[i][0] = i
           }
           for j in 0..<len_t {
               arr[0][j] = j
           }
           for i in 1..<len_s{
               for j in 1..<len_t{
                   arr[i][j] = min(arr[i-1][j],arr[i][j-1]) + 1
                   if (s[i-1] == t[j-1]){
                       arr[i][j] = min(arr[i][j],arr[i-1][j-1])
                   } else {
                       arr[i][j] = min(arr[i][j], arr[i-1][j-1] + 1)
                   }
                   if ((i >= 2) && (j >= 2) && (s[i-2] == t[j-1]) && (s[i-1] == t[j-2])){
                       arr[i][j] = min(arr[i][j], arr[i-2][j-2] + 1)
                   }
               }
           }
           print(str1)
           print(str2)
           print(arr[len_s-1][len_t-1])
           return arr[len_s-1][len_t-1]
       }
    
    func getReqForSearch(strSearch:String) {

        
        let http: HTTPCommunication = HTTPCommunication()
       
        let url: URL = URL(string: "https://demopet.herokuapp.com/apiv1/shelters/1")!

        http.retrieveURL(url) {
            [weak self] (data) -> Void in
            guard let json = String(data: data, encoding: String.Encoding.utf8) else { return }
            print("JSON: ", json)
                
            do {
                let jsonObject: [Shelter] = try! JSONDecoder().decode([Shelter].self, from: data)
                
                var extra:Int = 0
                var ans:Int = 100
                var shelt: Shelter!
                var i: Int = 0
                var n_cur: Int!
                for item in jsonObject{
                    extra = self?.Wagner_Fischer_for_Damerau_Levenshtein(str1: strSearch, str2: item.name) as! Int
                    if (extra < ans){
                        ans = extra
                        shelt = item
                        n_cur = i
                    }
                    i += 1
                }
                print (shelt.name)
                self?.shelterName.text = shelt.name
                self?.shelterLocation.text = shelt.location
                self?.shelterPhone.text = shelt.phone_number
                self?.shelterUrl.text = shelt.url
                self?.shelterMail.text = shelt.email
                self?.shelterPicture.image = UIImage(named: "shelter_test_1")
            } catch {
                print("Can't serialize data.")
            }
        }
    }
    
    func getReq(n:Int) {

        
        let http: HTTPCommunication = HTTPCommunication()
        let url: URL = URL(string: "https://demopet.herokuapp.com/apiv1/shelters/1")!

        http.retrieveURL(url) {
            [weak self] (data) -> Void in
            guard let json = String(data: data, encoding: String.Encoding.utf8) else { return }
            print("JSON: ", json)
                
            do {
                let jsonObject: [Shelter] = try! JSONDecoder().decode([Shelter].self, from: data)
                
                self?.shelterName.text = jsonObject[n].name
                self?.shelterLocation.text = jsonObject[n].location
                self?.shelterPhone.text = jsonObject[n].phone_number
                self?.shelterUrl.text = jsonObject[n].url
                self?.shelterMail.text = jsonObject[n].email
                self?.shelterPicture.image = UIImage(named: "shelter_test_"+"\(n)")
            } catch {
                print("Can't serialize data.")
            }
        }
    }
    
    func getReqafterSearch() {

        
        let http: HTTPCommunication = HTTPCommunication()
        let url: URL = URL(string: "https://demopet.herokuapp.com/apiv1/shelters/1")!

        http.retrieveURL(url) {
            [weak self] (data) -> Void in
            guard let json = String(data: data, encoding: String.Encoding.utf8) else { return }
            print("JSON: ", json)
                
            do {
                let jsonObject: [Shelter] = try! JSONDecoder().decode([Shelter].self, from: data)
                for item in jsonObject {
                    if (item.name == UserDefaults.standard.string(forKey: "sheltSearch")) {
                        self?.shelterName.text = item.name
                        self?.shelterLocation.text = item.location
                        self?.shelterPhone.text = item.phone_number
                        self?.shelterUrl.text = item.url
                        self?.shelterMail.text = item.email
                        self?.shelterPicture.image = UIImage(named: "shelter_test_1")
                    }
                }
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
