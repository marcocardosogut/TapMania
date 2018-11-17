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
    @IBOutlet weak var view_Insane: UIView!
    var viewStore : [UIView]!
    let defaults = UserDefaults.init()
    var difficult : Difficulty!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewStore = [view_Easy, view_Medium, view_Hard, view_Insane]
        loadDefaults()
        
        button_Background.layer.cornerRadius = 0.5 * button_Background.frame.size.height
        button_Background.layer.shadowColor = UIColor.black.cgColor
        button_Background.layer.shadowOffset = CGSize(width: 5, height: 5)
        button_Background.layer.shadowRadius = 5
        button_Background.layer.shadowOpacity = 1.0
        let height = UIScreen.main.bounds.height
        let widht  = UIScreen.main.bounds.width
        button_Back.frame = CGRect(x: 0, y: 0, width: widht, height: height)
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
