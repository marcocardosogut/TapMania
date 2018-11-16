//
//  GameOverViewController.swift
//  TapMania
//
//  Created by Marco Cardoso on 11/3/18.
//  Copyright © 2018 MCG_CODE. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    @IBOutlet weak var button_Menu: UIButton!
    @IBOutlet weak var button_PlayAgain: UIButton!
    @IBOutlet weak var label_NewRecord: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button_Menu.layer.cornerRadius = 0.5 * button_Menu.frame.size.height
        button_PlayAgain.layer.cornerRadius = 0.5 * button_PlayAgain.frame.size.height
    }
    
    @IBAction func returnMainMenu(_ sender: Any) {
        performSegue(withIdentifier: "segue_GameOverToMainMenu", sender: nil)
    }
    
    @IBAction func returnNewGame(_ sender: Any) {
        performSegue(withIdentifier: "segue_GameOverToPlay", sender: nil)
    }
}
