//
//  PlayerViewController.swift
//  TappingMania
//
//  Created by Marco Cardoso on 1/1/19.
//  Copyright © 2019 MCG_CODE. All rights reserved.
//

import UIKit
import AVKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var lable_Demo: UILabel!
    @IBOutlet weak var button_Skip: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "tutorialVideo", ofType: "mov")
        let videoURL = URL(fileURLWithPath: path!)
        let player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeView(note: )), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        self.view.bringSubviewToFront(self.lable_Demo)
        self.view.bringSubviewToFront(self.button_Skip)

    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    @objc private func changeView(note: NSNotification){
        performSegue(withIdentifier: "segue_PlayerToMainMenu", sender: nil)
    }
    
    @IBAction func buttonTouchInside(_ sender: Any) {
        performSegue(withIdentifier: "segue_PlayerToMainMenu", sender: nil)
    }
    
}
