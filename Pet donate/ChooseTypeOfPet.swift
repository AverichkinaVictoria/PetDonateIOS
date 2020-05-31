//
//  ChooseTypeOfPet.swift
//  Pet donate
//
//  Created by Виктория on 28.11.2019.
//  Copyright © 2019 Виктория. All rights reserved.
//

import UIKit

class ChooseTypeOfPet: UIViewController {
    
    @IBAction func color3Pressed(_ sender: Any) {
        log.info("Third color was chose")
        UserDefaults.standard.set(2, forKey: "color")
        var imgListArr1 :NSMutableArray = []
        for i in 0...89 {
            strName = "\(pictures[abs(n%3)])"+"_color3_stay000"+"\(i)"
            var image = UIImage(named: strName)
            imgListArr1.add(image as Any)
        }
        self.typePicture.animationImages = imgListArr1 as! [UIImage];
        self.typePicture.animationDuration = 4.0
        self.typePicture.startAnimating()
    }
    
    @IBAction func color2Pressed(_ sender: Any) {
        log.info("Second color was chose")
        UserDefaults.standard.set(1, forKey: "color")
        var imgListArr1 :NSMutableArray = []
        for i in 0...89 {
            strName = "\(pictures[abs(n%3)])"+"_color2_stay000"+"\(i)"
            var image = UIImage(named: strName)
            imgListArr1.add(image as Any)
        }
        self.typePicture.animationImages = imgListArr1 as! [UIImage];
        self.typePicture.animationDuration = 4.0
        self.typePicture.startAnimating()
    }
    
    @IBAction func color1Pressed(_ sender: Any) {
        log.info("First color was chose")
        UserDefaults.standard.set(0, forKey: "color")
        var imgListArr1 :NSMutableArray = []
        for i in 0...89 {
            strName = "\(pictures[abs(n%3)])"+"_color1_stay000"+"\(i)"
            var image = UIImage(named: strName)
            imgListArr1.add(image as Any)
        }
        self.typePicture.animationImages = imgListArr1 as! [UIImage];
        self.typePicture.animationDuration = 4.0
        self.typePicture.startAnimating()
    }
    
    @IBOutlet weak var color3: UIButton!
    @IBOutlet weak var color2: UIButton!
    @IBOutlet weak var color1: UIButton!
    
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var typePicture: UIImageView!
    
    var pictures: [String] = ["dog_buldog","dog_buldog","dog_poodle"]
    var colors: [String] = ["taksa_color","buldog_color","pooodle_color"]
    var colorsNum: [String] = ["color1","color2","color3"]
    var n:Int = 2
    var strName :String = ""
    
    @IBAction func back(_ sender: Any) {
        log.info("Back button was pressed")
        let vc = storyboard?.instantiateViewController(withIdentifier: "first") as! UIViewController
        self.present(vc, animated: true)
    }
    @IBAction func left(_ sender: Any) {
        log.info("Left button was pressed")
        self.typePicture.stopAnimating()
        var imgListArr1 :NSMutableArray = []
        
        n -= 1
        //type.text = types[abs(n%3)]
        for i in 0...89 {
            strName = "\(pictures[abs(n%3)])"+"_color1_stay000"+"\(i)"
            var image = UIImage(named: strName)
            imgListArr1.add(image as Any)
        }
        self.typePicture.animationImages = imgListArr1 as! [UIImage];
        self.typePicture.animationDuration = 4.0
        self.typePicture.startAnimating()
        setColors()
        
    }
    
    @IBAction func right(_ sender: Any) {
        log.info("Right button was pressed")
        self.typePicture.stopAnimating()
        var imgListArr :NSMutableArray = []
        n += 1
        for i in 0...89 {
            strName = "\(pictures[abs(n%3)])"+"_color1_stay000"+"\(i)"
            var image = UIImage(named: strName)
            imgListArr.add(image as Any)
        }
        self.typePicture.animationImages = imgListArr as! [UIImage];
        self.typePicture.animationDuration = 4.0
        self.typePicture.startAnimating()
        setColors()
    }
    
    
    @IBAction func choose(_ sender: Any) {
        log.info("Choose pet type was pressed")
        UserDefaults.standard.set([pictures[abs(n%3)]], forKey: "typePicture")
        UserDefaults.standard.set(abs(n%3), forKey: "type")
        log.info("Pet skin was saved")
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! UIViewController
        self.present(vc, animated: true)
    }
    override func viewDidLoad() {
        log.info("Skin choose screen was loaded")
        setColors()
        UserDefaults.standard.set(0, forKey: "color")
        var imgListArr :NSMutableArray = []
        for i in 0...89 {
            strName = "dog_poodle_color1_stay000"+"\(i)"
            var image = UIImage(named: strName)
            imgListArr.add(image as Any)
        }
        self.typePicture.animationImages = imgListArr as! [UIImage];
        self.typePicture.animationDuration = 4.0;
        self.typePicture.startAnimating()
        
        super.viewDidLoad()
        type.text = UserDefaults.standard.string(forKey: "name")
        typePicture.image = UIImage(named: pictures[2])
        // Do any additional setup after loading the view.
    }
    
      @objc func setColors(){
        log.info("Colors was reset")
       let colorStr1:String = "\(colors[abs(n%3)])"+"1"
        var imageColor1 = UIImage(named: colorStr1)
        color1.setBackgroundImage(imageColor1, for: UIControl.State.normal)
        
        let colorStr2:String = "\(colors[abs(n%3)])"+"2"
        var imageColor2 = UIImage(named: colorStr2)
        color2.setBackgroundImage(imageColor2, for: UIControl.State.normal)
        
        let colorStr3:String = "\(colors[abs(n%3)])"+"3"
        var imageColor3 = UIImage(named: colorStr3)
        color3.setBackgroundImage(imageColor3, for: UIControl.State.normal)
        
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
