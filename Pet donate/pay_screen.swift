//
//  pay_screen.swift
//  Pet donate
//
//  Created by Виктория on 03.05.2020.
//  Copyright © 2020 Виктория. All rights reserved.
//

import UIKit

class pay_screen: UIViewController {
    @IBOutlet weak var type_picture: UIImageView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBAction func right_click(_ sender: Any) {
        n += 1
        refresh()
    }
    
    @IBAction func left_click(_ sender: Any) {
        n -= 1
        refresh()
    }
    @IBAction func confirm(_ sender: Any) {
        var extra: Float = 0
        if (UserDefaults.standard.integer(forKey: "paidValue") != nil){
            var prev: Int = UserDefaults.standard.integer(forKey: "paidValue")
            UserDefaults.standard.set(prev+1, forKey: "paidValue")
        } else {
            UserDefaults.standard.set(1, forKey: "paidValue")
        }
        if (abs(n%3) == 0) {
            UserDefaults.standard.set("1", forKey: "typePaid")
            UserDefaults.standard.set(true, forKey: "changeBars")
            if (UserDefaults.standard.string(forKey: "typeOfPayment") == "health") {
                extra = UserDefaults.standard.float(forKey: "health")
                if (extra <= 0.8)  {
                    extra += 0.2
                    UserDefaults.standard.set(extra, forKey: "health")
                } else {
                    UserDefaults.standard.set(1.0, forKey: "health")
                }
            }  else if (UserDefaults.standard.string(forKey: "typeOfPayment") == "food") {
                extra = UserDefaults.standard.float(forKey: "food")
                if (extra <= 0.8) {
                    extra += 0.2
                    UserDefaults.standard.set(extra, forKey: "food")
                } else {
                    UserDefaults.standard.set(1.0, forKey: "food")
                }
            } else if (UserDefaults.standard.string(forKey: "typeOfPayment") == "fun")  {
                extra = UserDefaults.standard.float(forKey: "fun")
                if (extra <= 0.8) {
                    extra += 0.2
                    UserDefaults.standard.set(extra, forKey: "fun")
                } else {
                    UserDefaults.standard.set(1.0, forKey: "fun")
                }
            }
        }
        else if (abs(n%3) == 1) {
            UserDefaults.standard.set("2", forKey: "typePaid")
            UserDefaults.standard.set(true, forKey: "changeBars")
            if (UserDefaults.standard.string(forKey: "typeOfPayment") == "health") {
                extra = UserDefaults.standard.float(forKey: "health")
                if (extra <= 0.6) {
                    extra += 0.4
                    UserDefaults.standard.set(extra, forKey: "health")
                } else {
                    UserDefaults.standard.set(1.0, forKey: "health")
                }
            } else if (UserDefaults.standard.string(forKey: "typeOfPayment") == "food") {
                extra = UserDefaults.standard.float(forKey: "food")
                if (extra <= 0.6) {
                    extra += 0.4
                    UserDefaults.standard.set(extra, forKey: "food")
                } else {
                    UserDefaults.standard.set(1.0, forKey: "food")
                }
            } else if (UserDefaults.standard.string(forKey: "typeOfPayment") == "fun") {
                extra = UserDefaults.standard.float(forKey: "fun")
                if (extra <= 0.6) {
                    extra += 0.4
                    UserDefaults.standard.set(extra, forKey: "fun")
                } else {
                    UserDefaults.standard.set(1.0, forKey: "fun")
                }
            }
        } else {
            UserDefaults.standard.set("3", forKey: "typePaid")
            UserDefaults.standard.set(true, forKey: "changeBars")
            if (UserDefaults.standard.string(forKey: "typeOfPayment") == "health") {
                extra = UserDefaults.standard.float(forKey: "health")
                if (extra <= 0.4) {
                    extra += 0.6
                    UserDefaults.standard.set(extra, forKey: "health")
                } else {
                    UserDefaults.standard.set(1.0, forKey: "health")
                }
            } else if (UserDefaults.standard.string(forKey: "typeOfPayment") == "food") {
                extra = UserDefaults.standard.float(forKey: "food")
                if (extra <= 0.4) {
                    extra += 0.6
                    UserDefaults.standard.set(extra, forKey: "food")
                } else {
                    UserDefaults.standard.set(1.0, forKey: "food")
                }
            } else if (UserDefaults.standard.string(forKey: "typeOfPayment") == "fun") {
                extra = UserDefaults.standard.float(forKey: "fun")
                if (extra <= 0.4) {
                    extra += 0.6
                    UserDefaults.standard.set(extra, forKey: "fun")
                } else {
                    UserDefaults.standard.set(1.0, forKey: "fun")
                }
            }
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! UIViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! UIViewController
        self.present(vc, animated: true)
    }
    
    var pictures: [String] = []
    var price_title: [String] = ["100 рублей","300 рублей", "500 рублей"]
    var name_activity: [String] = []
    var n:Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
       if (UserDefaults.standard.string(forKey: "typeOfPayment") == "food")  {
        pictures = ["plate1_food1","plate1_food4","plate1_food5"]
        type.text = "Выберите корм:"
        name_activity = ["Корм \"Щенячья радость\"","Косточки","Стейк говяжий"]
        } else if (UserDefaults.standard.string(forKey: "typeOfPayment") == "fun") {
        pictures = ["play_1","play_2","play_3"]
        type.text = "Выберите способ игры:"
        name_activity = ["Мячик \"Вперед, приключения\"","Мячик \"Прочь, тоска\"","Игрушка \"Неутомимый\""]
        
       } else if (UserDefaults.standard.string(forKey: "typeOfPayment") == "health"){
        pictures = ["health_1","health_2","health_3"]
        type.text = "Выберите лекарство:"
        name_activity = ["Пилюли \"Хвост трубой\"","Таблетки \"Долой печаль\"","Укол \"Полон жизни\""]
        }
        
        refresh()

        // Do any additional setup after loading the view.
    }
    
  @objc func refresh(){
    type_picture.image = UIImage(named: pictures[abs(n%3)])
    price.text = price_title[abs(n%3)]
    name.text = name_activity[abs(n%3)]
    
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
