//
//  RecordViewController.swift
//  TappingMania
//
//  Created by Marco Cardoso on 11/3/18.
//  Copyright © 2018 MCG_CODE. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {
    //********* VISUALS *********
    @IBOutlet weak var button_Background: UIButton!
    @IBOutlet weak var button_Back: UIButton!
    @IBOutlet weak var label_EasyScore: UILabel!
    @IBOutlet weak var label_MediumScore: UILabel!
    @IBOutlet weak var label_HardScore: UILabel!
    @IBOutlet weak var label_UnfairScore: UILabel!
    @IBOutlet weak var view_Easy: UIView!
    @IBOutlet weak var view_Medium: UIView!
    @IBOutlet weak var view_Hard: UIView!
    @IBOutlet weak var view_Unfair: UIView!
    //********* END VISUALS *********
    
    private let defaults: UserDefaults = UserDefaults.init()    //Stores the app defaults values. Used to store settigns and records
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaults()
        
        Modelator.formatButton(buttons: [button_Background])
        Modelator.formatButtonBack(button: button_Back)        
    }
    
    @IBAction func returnMainMenu(_ sender: Any) {
        performSegue(withIdentifier: "segue_RecordsToMainMenu", sender: nil)
    }
    
    //Load the default score values
    private func loadDefaults(){
        loadDefaults(key: "Score_Easy")
        loadDefaults(key: "Score_Medium")
        loadDefaults(key: "Score_Hard")
        loadDefaults(key: "Score_Unfair")
    }
    
    //Load the default values and update the label text
    private func loadDefaults(key : String){
        let score = defaults.value(forKey: key) as! Int
        
        switch key {
        case "Score_Easy":
            updateLabelScore(label: label_EasyScore, score: score)
        case "Score_Medium":
            updateLabelScore(label: label_MediumScore, score: score)
        case "Score_Hard":
            updateLabelScore(label: label_HardScore, score: score)
        case "Score_Unfair":
            updateLabelScore(label: label_UnfairScore, score: score)
        default:
            print("Error: Default executed @loadDefaults RecordViewContoller")
        }
    }
    
    //Update Current score label
    private func updateLabelScore(label : UILabel, score : Int){
        label.text = String(score)
    }
}
