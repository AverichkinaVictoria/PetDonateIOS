//
//  ShelterCatalog.swift
//  Pet donate
//
//  Created by Виктория on 06.05.2020.
//  Copyright © 2020 Виктория. All rights reserved.
//

import UIKit

class ShelterCatalog: UIViewController {
    @IBAction func find(_ sender: Any) {
        log.debug("Find button was pressed")
        if (searchString.text != ""){
            log.info("Correst request")
            getReqForSearch(strSearch: searchString.text!)
            UserDefaults.standard.set(true, forKey: "search")
            UserDefaults.standard.set(searchString.text, forKey: "sheltSearch")
            print ("saved: "+"\(UserDefaults.standard.string(forKey: "sheltSearch"))")
        }
        else
        {
            log.info("Empty request")
            n = 0
            leftBttn.isHidden = true
            rightBttn.isHidden = false
            getReq(n: n)
            UserDefaults.standard.set(false, forKey: "search")
        }
    }
    @IBOutlet weak var searchString: UITextField!
    @IBOutlet weak var rightBttn: UIButton!
    @IBOutlet weak var leftBttn: UIButton!
    
    @IBAction func accountInfo(_ sender: Any) {
        log.debug("Account info was pressed")
         UserDefaults.standard.removeObject(forKey: "n")
        let vc = storyboard?.instantiateViewController(withIdentifier: "GoogleView") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func petCatalog(_ sender: Any) {
        log.debug("Pet catalog was pressed")
        UserDefaults.standard.removeObject(forKey: "n")
        let vc = storyboard?.instantiateViewController(withIdentifier: "catalogPet") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func petScreen(_ sender: Any) {
        log.debug("Main screen was pressed")
        UserDefaults.standard.removeObject(forKey: "n")
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! UIViewController
                      self.present(vc, animated: true)
    }
    
    @IBAction func more_pressed(_ sender: Any) {
        log.debug("More info was pressed")
        UserDefaults.standard.set(n, forKey: "n")
        let vc = storyboard?.instantiateViewController(withIdentifier: "cardOfShelter") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBOutlet weak var shelterlocation: UILabel!
    @IBOutlet weak var shelterName: UILabel!
    @IBAction func left_pressed(_ sender: Any) {
        log.debug("Left button was pressed")
        n -= 1
        if (n == 0) {
            leftBttn.isHidden = true
        } else {
            leftBttn.isHidden = false
        }
        rightBttn.isHidden = false
        getReq(n: n)
    }
   
    @IBAction func right_pressed(_ sender: Any) {
        log.debug("Right button was pressed")
        n += 1
        if (n == 0) {
            leftBttn.isHidden = true
        } else {
            leftBttn.isHidden = false
        }
        rightBttn.isHidden = false
        getReq(n: n)
    }
    
    var n: Int = 0
    @IBOutlet weak var shelterPicture: UIImageView!
    override func viewDidLoad() {
        log.debug("Shelter catalog was loaded")
        super.viewDidLoad()
        if (UserDefaults.standard.integer(forKey: "n") != nil) {
            n = UserDefaults.standard.integer(forKey: "n")
        }
        if (n == 0) {
            leftBttn.isHidden = true
        }
        rightBttn.isHidden = false
        getReq(n: n)
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
               
               NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

               NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
               
               view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
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
    
    func Wagner_Fischer_for_Damerau_Levenshtein(str1: String, str2:String) -> Int{
        log.info("Wagner Fisher was started")
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
        log.info("Wagner Fisher was ended")
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
                
                if (n < jsonObject.count){
                    self?.shelterName.text = jsonObject[n].name
                    self?.shelterlocation.text = jsonObject[n].location
                } else {
                    self?.rightBttn.isHidden = true
                }
                if (n + 1 == jsonObject.count) {
                    self?.rightBttn.isHidden = true
                }
                self?.shelterPicture.image = UIImage(named: "shelter_test_"+"\(n)")
               
            } catch {
                print("Can't serialize data.")
            }
        }
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
                self?.shelterlocation.text = shelt.location
                self?.leftBttn.isHidden = true
                self?.rightBttn.isHidden = true
                self?.shelterPicture.image = UIImage(named: "shelter_test_1")
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
