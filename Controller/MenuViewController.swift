//
//  MenuViewController.swift
//  TappingMania
//
//  Created by Marco Cardoso on 11/3/18.
//  Copyright © 2018 MCG_CODE. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import AVKit

class MenuViewController: UIViewController {
    //********* VISUALS *********
    @IBOutlet var generalView: UIView!
    @IBOutlet weak var button_Bottom: UIButton!
    @IBOutlet weak var button_Selected: UIButton!
    @IBOutlet weak var button_Top: UIButton!
    @IBOutlet weak var button_Middle: UIButton!
    @IBOutlet weak var button_SelectedOption: UIButton!
    @IBOutlet weak var button_Demo: UIButton!
    //********* END VISUALS *********
    
    private var currentSelection : gameMenu!        //Stores the menu selected (Center of the display)
    private let defaults = UserDefaults.init()      //Stores the app defaults values. Used to store settigns and records
    private var optionMusic : Bool = true           //Stores if the music option is enabled
    private var playDemo : Bool = false             //Stores if demo needs to be played
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaults()
        Modelator.playAudio(player: audioPlayer.Menu, play: optionMusic )
        
        button_Bottom.backgroundColor = #colorLiteral(red: 0.9993136525, green: 0.5816664696, blue: 0.001078070956, alpha: 1)
        button_Selected.backgroundColor = #colorLiteral(red: 0.3477838635, green: 0.7905586958, blue: 0.9795156121, alpha: 1)
        button_Top.backgroundColor = #colorLiteral(red: 0.2870728374, green: 0.8392896056, blue: 0.3857751787, alpha: 1)
        button_Middle.backgroundColor = #colorLiteral(red: 0.9996238351, green: 0.1655850112, blue: 0.3347808123, alpha: 1)
        currentSelection = gameMenu.Play
        let buttonContainer = [button_Top,button_Bottom,button_Middle,button_Selected]
        Modelator.formatButton(buttons: buttonContainer as! [UIButton])
        
        adjustVisual()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if playDemo{
            buttonDemo_TouchInside(button_Demo)
        }
    }
    
    @IBAction func button_ReplaceSelection(_ sender: UIButton) {
        Modelator.buttonPressAnimation(button: sender, playTap: true, play: optionMusic)
        updateCurrentSelection(sender)
        switchButton(sender)
        updateLabel()
    }
    
    @IBAction func selectedLabel_Touch(_ sender: Any) {
        changeMenuView()
    }
    
    @IBAction func selected_Touch(_ sender: UIButton) {
        Modelator.buttonPressAnimation(button: sender, playTap: true, play: optionMusic)
        changeMenuView()
    }
    
    @IBAction func buttonDemo_TouchInside(_ sender: UIButton) {
        performSegue(withIdentifier: "segue_MainMenuToPlayer", sender: nil)
    }
    
    //Loads all the default values of the app. In case that the app is ruuning for the first time
    //or the default never was setup if will initialize the values with predefined settings
    private func loadDefaults(){
        
        if (defaults.value(forKey: "Play_Demo") == nil){
            defaults.set(true, forKey: "Play_Demo")
            playDemo = true
        }
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
        
        optionMusic = defaults.bool(forKey: "Setting_Sound")
    }
    
    //Performs the segue transition to the selected menu
    private func changeMenuView(){
        performSegue(withIdentifier: currentSelection.rawValue, sender: nil)
    }
    
    //Switches the selected button with the current selection (Menu)
    private func switchButton(_ sender: UIButton){
        let image = button_Selected.currentImage
        let color = button_Selected.backgroundColor
        
        button_Selected.setImage(sender.currentImage, for: .normal)
        button_Selected.backgroundColor = sender.backgroundColor
        
        sender.setImage(image, for: .normal)
        sender.backgroundColor = color
    }
    
    //Updates the menu selected using a given button
    private func updateCurrentSelection(_ sender: UIButton){
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
    
    //Updates label of the selected menu
    private func updateLabel(){
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
        button_SelectedOption.setTitle(labelText, for: .normal)
    }
    
    //Only for devices with small displays. Adjust components to make it fit on the display
    private func adjustVisual(){
        if(Modelator.detectHomeButtonModel()){
            button_Bottom.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
            if(!Modelator.detectHomeButtonPlusModel()){
            button_SelectedOption.titleLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 40, weight: UIFont.Weight.heavy)
            }
        }
    }
}
