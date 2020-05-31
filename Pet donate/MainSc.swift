//
//  ChooseTypeOfPet.swift
//  Pet donate
//
//  Created by Виктория on 28.11.2019.
//  Copyright © 2019 Виктория. All rights reserved.
//

import UIKit


class MainSc: UIViewController {
    
    @IBAction func shelterCatalog(_ sender: Any) {
        log.debug("Shelter catalog was pressed")
        let vc = storyboard?.instantiateViewController(withIdentifier: "CatalogOfShelters") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func catalogPet_pressed(_ sender: Any) {
        log.debug("Pet catalog was pressed")
    let vc = storyboard?.instantiateViewController(withIdentifier: "catalogPet") as! UIViewController
    self.present(vc, animated: true)
    }
    
    @IBAction func change_pet(_ sender: Any) {
        log.debug("Change pet was pressed")
       let vc = storyboard?.instantiateViewController(withIdentifier: "petChange") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func AccountInfo(_ sender: Any) {
        log.debug("Account info was pressed")
        let vc = storyboard?.instantiateViewController(withIdentifier: "GoogleView") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBOutlet weak var meal: UIImageView!
    
    @IBAction func healthPlus(_ sender: Any) {
        log.debug("Health plus bar was pressed")
        saveProgressBars()
        UserDefaults.standard.set("health", forKey: "typeOfPayment")
       let vc = storyboard?.instantiateViewController(withIdentifier: "screen_4") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func funPlus(_ sender: Any) {
        log.debug("Fun plus bar was pressed")
        saveProgressBars()
        UserDefaults.standard.set("fun", forKey: "typeOfPayment")
        let vc = storyboard?.instantiateViewController(withIdentifier: "screen_4") as! UIViewController
        self.present(vc, animated: true)
    }
    
    
    @IBAction func foodPlus(_ sender: Any) {
        log.debug("Food plus bar was pressed")
        saveProgressBars()
        UserDefaults.standard.set("food", forKey: "typeOfPayment")
        let vc = storyboard?.instantiateViewController(withIdentifier: "screen_4") as! UIViewController
        self.present(vc, animated: true)
        
    }
  
    @IBOutlet weak var foodPlus: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var pet: UIImageView!
    @IBOutlet weak var petBack: UIImageView!
    @IBOutlet weak var profileBack: UIImageView!
    @IBOutlet weak var food: UIProgressView!
    @IBOutlet weak var health: UIProgressView!
    @IBOutlet weak var fun: UIProgressView!
    var timerFood: Timer!
    var timerHealth: Timer!
    var timerFun: Timer!
    var colorsNum: [String] = ["color1","color2","color3"]
    var pictures: [String] = ["dog_buldog","dog_buldog","dog_poodle"]
   
    override func viewDidLoad()
    {
        log.debug("Main screen was loaded")
        if (UserDefaults.standard.string(forKey: "food") != nil) {
            food.progress = UserDefaults.standard.float(forKey: "food")
            fun.progress = UserDefaults.standard.float(forKey: "fun")
            health.progress = UserDefaults.standard.float(forKey: "health")
                       
            }
               foodColor()
               funColor()
               healthColor()
               
               timerFood = Timer.scheduledTimer(timeInterval: 10800, target: self, selector: #selector(self.showProgressFood), userInfo: nil, repeats: true)
               timerHealth = Timer.scheduledTimer(timeInterval: 10800, target: self, selector: #selector(self.showProgressHealth), userInfo: nil, repeats: true)
               timerFun = Timer.scheduledTimer(timeInterval: 10800, target: self, selector: #selector(self.showProgressFun), userInfo: nil, repeats: true)

               super.viewDidLoad()
               name.text = UserDefaults.standard.string(forKey: "name")
               
               emotionCheck()
        
        if (!UserDefaults.standard.bool(forKey: "requested"))
        {
           // getReq2()
        }
        
        
        // Do any additional setup after loading the view.
    }
    @objc func getReq1()
    {
        print ("try\n")
               if let url = URL(string: "https://demopet.herokuapp.com/apiv1/shelters/1") {
                  URLSession.shared.dataTask(with: url) { data, response, error in
                     if let data = data {
                        if let jsonString = String(data: data, encoding: .utf8) {
                           print(jsonString)
                        }
                      }
                  }.resume()
               }
    }
    
    @objc func getReq2()
    {
        var res = [Animal]()
        UserDefaults.standard.set(true, forKey: "requested")
        print ("try\n")
        if let url = URL(string: "https://demopet.herokuapp.com/apiv1/shelters/1") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                 if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                 }
                print ("new obj")
                
                let res: [Shelter] = try! JSONDecoder().decode([Shelter].self, from: data)
                print (res[0].account)
                
               }
            
            
           }.resume()
        }
    }
    
     @objc func getReq()
     {
        print ("try\n")
        if let url = URL(string: "https://demopet.herokuapp.com/test") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                 if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                 }
               }
           }.resume()
        }
       
       
    }
    
    @objc func upgradeBars() {
        log.debug("Bars were upgraded")
        if (UserDefaults.standard.string(forKey: "typeOfPayment") == "health") {
            if (UserDefaults.standard.string(forKey: "typePaid") == "1") {
                if (health.progress <= 0.8) {
                    health.progress += 0.2
                    print("health+0,2")
                } else {
                    health.progress = 1.0
                     print("health=1")
                }
            } else if (UserDefaults.standard.string(forKey: "typePaid") == "2") {
                if (health.progress <= 0.6) {
                    health.progress += 0.4
                     print("health+0,4")
                } else {
                    health.progress = 1.0
                     print("health=1")
                }
            } else if (UserDefaults.standard.string(forKey: "typePaid") == "3") {
                if (health.progress <= 0.4) {
                    health.progress += 0.6
                     print("health+0,6")
                } else {
                    health.progress = 1.0
                     print("health=1")
                }
            }
            healthColor()
            UserDefaults.standard.set(health.progress, forKey: "health")
        } else if (UserDefaults.standard.string(forKey: "typeOfPayment") == "fun") {
            if (UserDefaults.standard.string(forKey: "typePaid") == "1") {
                if (fun.progress <= 0.8) {
                    fun.progress += 0.2
                     print("fun+0,2")
                } else {
                    fun.progress = 1.0
                     print("fun=1")
                }
            }
            else if (UserDefaults.standard.string(forKey: "typePaid") == "2") {
                if (fun.progress <= 0.6) {
                    fun.progress += 0.4
                     print("fun+0,4")
                } else {
                    fun.progress = 1.0
                     print("fun=1")
                }
            } else if (UserDefaults.standard.string(forKey: "typePaid") == "3") {
                if (fun.progress <= 0.4) {
                    fun.progress += 0.6
                     print("fun+0,6")
                } else {
                    fun.progress = 1.0
                     print("fun=1")
                }
            }
            funColor()
            UserDefaults.standard.set(fun.progress, forKey: "fun")
        } else if (UserDefaults.standard.string(forKey: "typeOfPayment") == "food") {
           if (UserDefaults.standard.string(forKey: "typePaid") == "1") {
                if (food.progress <= 0.8)  {
                    food.progress += 0.2
                     print("food+0,2")
                } else {
                    food.progress = 1.0
                     print("food=1")
                }
            } else if (UserDefaults.standard.string(forKey: "typePaid") == "2") {
                if (food.progress <= 0.6) {
                    food.progress += 0.4
                     print("food+0.4")
                }   else  {
                    food.progress = 1.0
                     print("food=1")
                }
            } else if (UserDefaults.standard.string(forKey: "typePaid") == "3") {
                if (food.progress <= 0.4) {
                    food.progress += 0.6
                     print("food+0,6")
                } else {
                    food.progress = 1.0
                     print("food=1")
                }
            }
            foodColor()
            UserDefaults.standard.set(food.progress, forKey: "food")
        }
        emotionCheck()
        checkMeal()
        saveProgressBars()
        print ("in upgradebars func:\n")
        print ("food: " + "\(UserDefaults.standard.float(forKey: "food"))")
        print ("fun: " + "\(UserDefaults.standard.float(forKey: "fun"))")
        print ("health: " + "\(UserDefaults.standard.float(forKey: "health"))")
    }
    @objc func happyAnimation()
      {
        var imgListArr :NSMutableArray = []
        for i in 0...89{
            let strName:String = "\(pictures[UserDefaults.standard.integer(forKey: "type")])"+"_"+"\(colorsNum[UserDefaults.standard.integer(forKey: "color")])"+"_stay000"+"\(i)"

            var image = UIImage(named: strName)
            imgListArr.add(image as Any)
        }
        self.pet.animationImages = imgListArr as! [UIImage];
        self.pet.animationDuration = 4.0;
        self.pet.startAnimating()
        
    }
    
    @objc func sadAnimation()
      {
        var pictures: [String] = ["dog_buldog","dog_buldog","dog_poodle"]
        var imgListArr :NSMutableArray = []
        for i in 0...44 {
         var strName = "\(pictures[UserDefaults.standard.integer(forKey: "type")])"+"_"+"\(colorsNum[UserDefaults.standard.integer(forKey: "color")])"+"_sad000"+"\(i)"
            var image = UIImage(named: strName)
            imgListArr.add(image as Any)
        }
        self.pet.animationImages = imgListArr as! [UIImage];
        self.pet.animationDuration = 2.0;
        self.pet.startAnimating()
        
    }
    
    @objc func verySadAnimation()
      {
        var pictures: [String] = ["dog_buldog","dog_buldog","dog_poodle"]
        var imgListArr :NSMutableArray = []
        for i in 0...44 {
         var strName = "\(pictures[UserDefaults.standard.integer(forKey: "type")])"+"_"+"\(colorsNum[UserDefaults.standard.integer(forKey: "color")])"+"_verysad000"+"\(i)"
            var image = UIImage(named: strName)
            imgListArr.add(image as Any)
        }
        self.pet.animationImages = imgListArr as! [UIImage];
        self.pet.animationDuration = 2.0;
        self.pet.startAnimating()
        
    }
    
     @objc func emotionCheck()
     {
        if (food.progress <= 0.3 || health.progress <= 0.3 || fun.progress <= 0.3) {
            verySadAnimation()
        }else if (((food.progress <= 0.5)&&(food.progress > 0.3)) || (((fun.progress <= 0.5)&&(fun.progress > 0.3))) || (((health.progress <= 0.5)&&(health.progress > 0.3)))) {
                sadAnimation()
            } else {
            happyAnimation()
        }
    }
    
    @objc func checkMeal()
    {
        if (food.progress <= 0.5){
            meal.isHidden = true
        } else {
            meal.isHidden = false
        }
    }
    
    @objc func showProgressFood()
    {
        if (food.progress == 0)
        {
            
        } else if (food.progress >= 0.1) {
            food.progress -= 0.1
            foodColor()
            emotionCheck()
            checkMeal()
            saveProgressBars()
        }
    }
    
    @objc func showProgressHealth()
       {
           if (health.progress == 0)
           {
               
           } else if (health.progress >= 0.1) {
               health.progress -= 0.1
            healthColor()
            emotionCheck()
            saveProgressBars()
           }
       }
    
    @objc func showProgressFun()
       {
           if (fun.progress == 0)
           {
               
           }else if (fun.progress >= 0.1){
            fun.progress -= 0.1
            funColor()
            emotionCheck()
            saveProgressBars()
            }
           
       }
    
    @objc func foodColor()
    {
        if (food.progress <= 0.3)
         {
             food.progressTintColor = UIColor(red: 0.90, green: 0.36, blue: 0.06, alpha: 1.0)
         }
         else if (food.progress <= 0.7 && food.progress > 0.3)
         {
             food.progressTintColor = UIColor(red: 0.90, green: 0.87, blue: 0.06, alpha: 1.0)
         }
        
         else
         {
             food.progressTintColor = UIColor(red: 0.20, green: 0.78, blue: 0.10, alpha: 1.0)
         }
    }
     @objc func healthColor()
     {
        if (health.progress <= 0.3)
         {
             health.progressTintColor = UIColor(red: 0.90, green: 0.36, blue: 0.06, alpha: 1.0)
         }
         else if (health.progress <= 0.7 && health.progress > 0.3)
         {
             health.progressTintColor = UIColor(red: 0.90, green: 0.87, blue: 0.06, alpha: 1.0)
         }
        
         else
         {
             health.progressTintColor = UIColor(red: 0.20, green: 0.78, blue: 0.10, alpha: 1.0)
         }
    }
    
     @objc func funColor()
     {
        if (fun.progress <= 0.3)
                     {
                         fun.progressTintColor = UIColor(red: 0.90, green: 0.36, blue: 0.06, alpha: 1.0)
                     }
                     else if (fun.progress <= 0.7 && fun.progress > 0.3)
                     {
                         fun.progressTintColor = UIColor(red: 0.90, green: 0.87, blue: 0.06, alpha: 1.0)
                     }
                    
                     else
                     {
                         fun.progressTintColor = UIColor(red: 0.20, green: 0.78, blue: 0.10, alpha: 1.0)
                     }
    }
    
    @objc func saveProgressBars()
    {
        log.info("Bars were saved")
        UserDefaults.standard.set(food.progress, forKey: "food")
        UserDefaults.standard.set(fun.progress, forKey: "fun")
        UserDefaults.standard.set(health.progress, forKey: "health")
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
