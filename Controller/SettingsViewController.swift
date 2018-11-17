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
        Modelator.formatButton(buttons: [button_Background])
        Modelator.formatButtonBack(button: button_Back)
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
