//
//  MenuViewController.swift
//  TapMania
//
//  Created by Marco Cardoso on 11/3/18.
//  Copyright © 2018 MCG_CODE. All rights reserved.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    //********* VISUALS *********
    @IBOutlet weak var button_Bottom: UIButton!
    @IBOutlet weak var button_Selected: UIButton!
    @IBOutlet weak var button_Top: UIButton!
    @IBOutlet weak var button_Middle: UIButton!
    @IBOutlet weak var button_Label: UIButton!
    //********* END VISUALS *********
    var currentSelection : gameMenu!
    let defaults = UserDefaults.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaults()
        Modelator.playAudio(player: audioPlayer.Menu )
        
        print(UIDevice.current.name)
        
        button_Bottom.backgroundColor = #colorLiteral(red: 0.9993136525, green: 0.5816664696, blue: 0.001078070956, alpha: 1)
        button_Selected.backgroundColor = #colorLiteral(red: 0.3477838635, green: 0.7905586958, blue: 0.9795156121, alpha: 1)
        button_Top.backgroundColor = #colorLiteral(red: 0.2870728374, green: 0.8392896056, blue: 0.3857751787, alpha: 1)
        button_Middle.backgroundColor = #colorLiteral(red: 0.9996238351, green: 0.1655850112, blue: 0.3347808123, alpha: 1)
        currentSelection = gameMenu.Play
        let buttonContainer = [button_Top,button_Bottom,button_Middle,button_Selected]
        Modelator.formatButton(buttons: buttonContainer as! [UIButton])
        if(Modelator.detectHomeButtonModel()){
            button_Bottom.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        }
        // Do any additional setup after loading the view.
    }
    
    func loadDefaults(){
        if (defaults.value(forKey: "Setting_Sound") == nil){
            defaults.set(true, forKey: "Setting_Sound")
        }
        if (defaults.value(forKey: "Setting_Vibration") == nil){
            defaults.set(true, forKey: "Setting_Vibration")
        }
        if (defaults.value(forKey: "Difficult") == nil){
            defaults.set(Difficulty.Easy.rawValue, forKey: "Difficult")
        }
        if (defaults.value(forKey: "Score_Easy") == nil){
            defaults.set(0, forKey: "Score_Easy")
        }
        if (defaults.value(forKey: "Score_Medium") == nil){
            defaults.set(0, forKey: "Score_Medium")
        }
        if (defaults.value(forKey: "Score_Hard") == nil){
            defaults.set(0, forKey: "Score_Hard")
        }
        if (defaults.value(forKey: "Score_Unfair") == nil){
            defaults.set(0, forKey: "Score_Unfair")
        }
        defaults.synchronize()
    }
    
    @IBAction func button_ReplaceSelection(_ sender: UIButton) {
        Modelator.buttonPressAnimation(button: sender, playTap: true)
        updateCurrentSelection(sender)
        switchButton(sender)
        updateLabel()
    }
    
    @IBAction func selectedLabel_Touch(_ sender: Any) {
        changeMenuView()
    }
    
    @IBAction func selected_Touch(_ sender: UIButton) {
        Modelator.buttonPressAnimation(button: sender, playTap: true)
        changeMenuView()
    }
    
    func changeMenuView(){
        performSegue(withIdentifier: currentSelection.rawValue, sender: nil)
    }
    
    func switchButton(_ sender: UIButton){
        let image = button_Selected.currentImage
        let color = button_Selected.backgroundColor
        
        button_Selected.setImage(sender.currentImage, for: .normal)
        button_Selected.backgroundColor = sender.backgroundColor
        
        sender.setImage(image, for: .normal)
        sender.backgroundColor = color
    }
    
    func updateCurrentSelection(_ sender: UIButton){
        switch sender.backgroundColor {
        case #colorLiteral(red: 0.9996238351, green: 0.1655850112, blue: 0.3347808123, alpha: 1):
            currentSelection = .Records
        case #colorLiteral(red: 0.3477838635, green: 0.7905586958, blue: 0.9795156121, alpha: 1):
            currentSelection = .Play
        case #colorLiteral(red: 0.9993136525, green: 0.5816664696, blue: 0.001078070956, alpha: 1):
            currentSelection = .Difficult
        case #colorLiteral(red: 0.2870728374, green: 0.8392896056, blue: 0.3857751787, alpha: 1):
            currentSelection = .Settings
        default:
            print("Error: Invalid Color selection @updateCurrentSelection. Default executed")
        }
    }
    
    func updateLabel(){
        var labelText = ""
        switch currentSelection! {
        case .Difficult:
            labelText = "DIFFICULT"
        case .Play:
            labelText = "PLAY"
        case .Records:
            labelText = "RECORDS"
        case .Settings:
            labelText = "SETTINGS"
            break
        }
        button_Label.setTitle(labelText, for: .normal)
    }
}
