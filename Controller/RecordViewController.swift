//
//  RecordViewController.swift
//  TapMania
//
//  Created by Marco Cardoso on 11/3/18.
//  Copyright © 2018 MCG_CODE. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {
    @IBOutlet weak var button_Background: UIButton!
    @IBOutlet weak var button_Back: UIButton!
    @IBOutlet weak var label_EasyScore: UILabel!
    @IBOutlet weak var label_MediumScore: UILabel!
    @IBOutlet weak var label_HardScore: UILabel!
    @IBOutlet weak var label_UnfairScore: UILabel!
    
    let defaults: UserDefaults = UserDefaults.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaults()
        
        button_Background.layer.cornerRadius = 0.5 * button_Background.frame.size.height
        button_Background.layer.shadowColor = UIColor.black.cgColor
        button_Background.layer.shadowOffset = CGSize(width: 5, height: 5)
        button_Background.layer.shadowRadius = 5
        button_Background.layer.shadowOpacity = 1.0
        let height = UIScreen.main.bounds.height
        let widht  = UIScreen.main.bounds.width
        button_Back.frame = CGRect(x: 0, y: 0, width: widht, height: height)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func returnMainMenu(_ sender: Any) {
        performSegue(withIdentifier: "segue_RecordsToMainMenu", sender: nil)
    }
    
    func loadDefaults(){
        loadDefaults(key: "Score_Easy")
        loadDefaults(key: "Score_Medium")
        loadDefaults(key: "Score_Hard")
        loadDefaults(key: "Score_Unfair")
    }
    
    func loadDefaults(key : String){
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
    
    func updateLabelScore(label : UILabel, score : Int){
        label.text = String(score)
    }
}
