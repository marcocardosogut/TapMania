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
        //b.layer.cornerRadius = 0.5 * b.frame.size.height
        button_Menu.layer.cornerRadius = 0.5 * button_Menu.frame.size.height
        button_PlayAgain.layer.cornerRadius = 0.5 * button_PlayAgain.frame.size.height

        // Do any additional setup after loading the view.
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
