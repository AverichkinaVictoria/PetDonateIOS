//
//  Start.swift
//  Pet donate
//
//  Created by Виктория on 03.05.2020.
//  Copyright © 2020 Виктория. All rights reserved.
//

import UIKit

class Start: UIViewController {
    @IBOutlet weak var second_dog: UIImageView!
    
    @IBOutlet weak var first_dog: UIImageView!
    
     var progress: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(false, forKey: "requested")
        firstAnimation()
        secondAnimation()
        progress = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.startDemo), userInfo: nil, repeats: true)
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func startDemo() {
        self.first_dog.stopAnimating()
        self.second_dog.stopAnimating()
       DispatchQueue.main.async {
                  if ((UserDefaults.standard.string(forKey: "type") != nil) && (UserDefaults.standard.string(forKey: "name") != nil)) {
                  let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! UIViewController
                  self.present(vc, animated: true)
                  } else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "intro1") as! UIViewController
                    self.present(vc, animated: true)
        }
              }
    }
    @objc func firstAnimation() {
        var imgListArr :NSMutableArray = []
        for i in 0...89 {
            let strName:String = "dog_poodle_color1_stay000"+"\(i)"

            var image = UIImage(named: strName)
            imgListArr.add(image as Any)
        }
        self.first_dog.animationImages = imgListArr as! [UIImage];
        self.first_dog.animationDuration = 4.0;
    }
    
    @objc func secondAnimation() {
        var imgListArr :NSMutableArray = []
        for i in 0...89 {
            let strName:String = "dog_buldog_color1_stay000"+"\(i)"

            var image = UIImage(named: strName)
            imgListArr.add(image as Any)
        }
        self.first_dog.animationImages = imgListArr as! [UIImage];
        self.first_dog.animationDuration = 4.0;
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
