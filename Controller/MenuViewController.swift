//
//  MenuViewController.swift
//  TapMania
//
//  Created by Marco Cardoso on 11/3/18.
//  Copyright © 2018 MCG_CODE. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    //********* VISUALS *********
    @IBOutlet weak var button_Bottom: UIButton!
    @IBOutlet weak var button_Selected: UIButton!
    @IBOutlet weak var button_Top: UIButton!
    @IBOutlet weak var button_Middle: UIButton!
    @IBOutlet weak var label_Action: UILabel!
    //********* END VISUALS *********
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonContainer = [button_Top,button_Bottom,button_Middle,button_Selected]
        formatButton(buttons: buttonContainer as! [UIButton])
        // Do any additional setup after loading the view.
    }
    
    private func formatButton(buttons: [UIButton])
    {
        for b in buttons
        {
            b.layer.cornerRadius = 0.5 * b.frame.size.height
            b.layer.shadowColor = UIColor.black.cgColor
            b.layer.shadowOffset = CGSize(width: 5, height: 5)
            b.layer.shadowRadius = 5
            b.layer.shadowOpacity = 1.0
        }
    }
    
    @IBAction func button_ReplaceSelection(_ sender: UIButton) {
        buttonPressAnimation(button: sender)
    }
    
    private func buttonPressAnimation (button: UIButton)
    {
        UIButton.animate(withDuration: 0.1,
                         animations:{button.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)},
                         completion:{ finish in UIButton.animate(withDuration: 0.1,
                                                                 animations: {button.transform = CGAffineTransform.identity})})
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
