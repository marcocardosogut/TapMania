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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func returnMainMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "segue_SettingsToMainMenu", sender: nil)
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
