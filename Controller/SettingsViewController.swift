//
//  SettingsViewController.swift
//  TapMania
//
//  Created by Marco Cardoso on 11/3/18.
//  Copyright © 2018 MCG_CODE. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var button_Background: UIButton!
    @IBOutlet weak var button_Back: UIButton!
    @IBOutlet weak var button_Sound: UIButton!
    @IBOutlet weak var button_Vibration: UIButton!
    let defaults = UserDefaults.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtons()
        //loadDefaults()
        
        button_Background.layer.cornerRadius = 0.5 * button_Background.frame.size.height
        button_Background.layer.shadowColor = UIColor.black.cgColor
        button_Background.layer.shadowOffset = CGSize(width: 5, height: 5)
        button_Background.layer.shadowRadius = 5
        button_Background.layer.shadowOpacity = 1.0
        
        let height = UIScreen.main.bounds.height
        let widht  = UIScreen.main.bounds.width
        button_Back.frame = CGRect(x: 0, y: 0, width: widht, height: height)
    }
    
    @IBAction func returnMainMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "segue_SettingsToMainMenu", sender: nil)
    }
    
    @IBAction func settingTouch(_ sender: UIButton) {
        var option  = "Setting_Sound"
        if (sender.titleLabel?.text == "VIBRATION"){
            option = "Setting_Vibration"
        }
        let temp = !defaults.bool(forKey: option)
        defaults.set(temp, forKey: option)
        defaults.synchronize()
        if (temp){
            sender.alpha = 1
        }else{
            sender.alpha = 0.5
        }
    }
    
    func updateButtons() {
        if (!(defaults.value(forKey: "Setting_Sound") as! Bool)){
            button_Sound.alpha = 0.5
        }
        if (!(defaults.value(forKey: "Setting_Vibration") as! Bool)){
            button_Vibration.alpha = 0.5
        }
    }
}
