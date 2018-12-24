//
//  DifficultViewController.swift
//  TapMania
//
//  Created by Marco Cardoso on 11/3/18.
//  Copyright © 2018 MCG_CODE. All rights reserved.
//

import UIKit

class DifficultViewController: UIViewController {
    @IBOutlet weak var button_Background: UIButton!
    @IBOutlet weak var button_Back: UIButton!
    
    @IBOutlet weak var view_Easy: UIView!
    @IBOutlet weak var view_Medium: UIView!
    @IBOutlet weak var view_Hard: UIView!
    @IBOutlet weak var view_Unfair: UIView!
    var viewStore : [UIView]!
    let defaults = UserDefaults.init()
    var difficult : Difficulty!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewStore = [view_Easy, view_Medium, view_Hard, view_Unfair]
        loadDefaults()
        
        Modelator.formatButton(buttons: [button_Background])
        Modelator.formatButtonBack(button: button_Back)
        
        if(UIDevice.current.name.contains("SE") || UIDevice.current.name.contains("5")){
             view_Easy.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            view_Medium.topAnchor.constraint(equalTo: view_Easy.bottomAnchor).isActive = true
            view_Hard.topAnchor.constraint(equalTo: view_Medium.bottomAnchor).isActive = true
            view_Unfair.topAnchor.constraint(equalTo: view_Hard.bottomAnchor).isActive = true
        }
    }
    
    @IBAction func difficultChange(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "EASY":
            difficult = .Easy
        case "MEDIUM":
            difficult = .Medium
        case "HARD":
            difficult = .Hard
        case "UNFAIR":
            difficult = .Unfair
        default:
            print("Error @difficultChange. Default executed.")
        }
        defaults.set(difficult.rawValue, forKey: "Difficult")
        defaults.synchronize()
        updateDifficultView()
    }
    
    func updateDifficultView(){
        var i = 0
        while i<4 {
            if i != difficult.rawValue{
                viewStore[i].alpha = 0.5
            }
            else{
                viewStore[i].alpha = 1
            }
            i += 1
        }
    }
    
    func loadDefaults(){
        difficult = Difficulty(rawValue: (defaults.value(forKey: "Difficult") as! Int))!
        updateDifficultView()
    }
    
    @IBAction func returnMainMenu(_ sender: Any) {
        performSegue(withIdentifier: "segue_DifficultToMainMenu", sender: nil)
    }
}
