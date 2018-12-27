//
//  SettingsViewController.swift
//  TappingMania
//
//  Created by Marco Cardoso on 11/3/18.
//  Copyright © 2018 MCG_CODE. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    //********* VISUALS *********
    @IBOutlet weak var button_Background: UIButton!
    @IBOutlet weak var button_Back: UIButton!
    @IBOutlet weak var button_Sound: UIButton!
    @IBOutlet weak var button_Vibration: UIButton!
    //********* END VISUALS *********
    
    let defaults = UserDefaults.init()      //Stores the app defaults values. Used to store settigns and records
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtons()
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
        if(option == "Setting_Sound"){
            if(!temp){
                Modelator.stopAudio()
            }
            else{
                Modelator.playAudio(player: .Menu, play: true)
            }
        }
    }
    
    //Update the alpha value of the buttons. To represent enable and disable
    private func updateButtons() {
        if (!(defaults.value(forKey: "Setting_Sound") as! Bool)){
            button_Sound.alpha = 0.5
        }
        if (!(defaults.value(forKey: "Setting_Vibration") as! Bool)){
            button_Vibration.alpha = 0.5
        }
    }
}
