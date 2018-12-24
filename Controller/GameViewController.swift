//
//  ViewController.swift
//  TapMania
//
//  Created by Marco Cardoso on 11/2/18.
//  Copyright © 2018 MCG_CODE. All rights reserved.
//

import UIKit
import AudioToolbox

class GameViewController: UIViewController {
    var gameModel : GameTapMania!
    var defaults : UserDefaults = UserDefaults.init()
    var optionMusic : Bool = true
    var optionVibration : Bool = true
    
    let colors = [#colorLiteral(red: 0.9996238351, green: 0.1655850112, blue: 0.3347808123, alpha: 1),#colorLiteral(red: 0.3477838635, green: 0.7905586958, blue: 0.9795156121, alpha: 1),#colorLiteral(red: 0.9993136525, green: 0.5816664696, blue: 0.001078070956, alpha: 1),#colorLiteral(red: 0.2870728374, green: 0.8392896056, blue: 0.3857751787, alpha: 1)]
    var tick = 60
    var refreshInterval = 3
    var timer : Timer?
    var buttonContainer : [UIButton] = []
    
    //********* VISUAL CONTROLERS *********
    @IBOutlet weak var button_TL: UIButton!
    @IBOutlet weak var button_BL: UIButton!
    @IBOutlet weak var button_TR: UIButton!
    @IBOutlet weak var button_BR: UIButton!
    @IBOutlet weak var button_C: UIButton!
    @IBOutlet weak var label_Score: UILabel!
    @IBOutlet weak var label_Timer: UILabel!
    @IBOutlet weak var imageTimer: UIImageView!
    //********* END VISUAL CONTROLERS *********
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGame()
        Modelator.playAudio(player: audioPlayer.InGame, play: optionMusic)
        
        buttonContainer = [button_TL,button_BL,button_TR,button_BR,button_C]
        Modelator.formatButton(buttons: buttonContainer)
        setButtonColors()
        runTimer()
        
        //Fix layout for devices with Home Button
        if(Modelator.detectHomeButtonModel()){
            button_BL.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
            button_BR.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
            label_Timer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
            imageTimer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        }
    }
    
    func loadGame(){
        let dificulty = Difficulty(rawValue: defaults.value(forKey: "Difficult") as! Int)
        gameModel = GameTapMania(difficult: dificulty!)
        if(dificulty == Difficulty.Unfair){
            refreshInterval = 4
        }else if(dificulty == Difficulty.Hard ){
            refreshInterval = 2
        }
        
        optionMusic = defaults.bool(forKey: "Setting_Sound")
        optionVibration = defaults.bool(forKey: "Setting_Vibration")
    }
    
    func updateScoreValue(){
        var scoreKey = ""
        switch gameModel.getDifficult() {
        case .Easy:
            scoreKey = "Score_Easy"
        case .Medium:
            scoreKey = "Score_Medium"
        case .Hard:
            scoreKey = "Score_Hard"
        case .Unfair:
            scoreKey = "Score_Unfair"
        }
        let stablishedScore = defaults.value(forKey: scoreKey) as! Int
        if (stablishedScore < gameModel.getScore()){
            defaults.set(gameModel.getScore(), forKey: scoreKey)
            defaults.set(true, forKey: "NewRecord")
            defaults.synchronize()
        }
    }
    
    @IBAction func button_Press(_ sender: UIButton) {
        let t = Modelator.convertColorToEnumValue(color: sender.backgroundColor!)
        produceVibration(evaluation: gameModel.evaluate(played: t))
        updateScoreLabel()
        Modelator.buttonPressAnimation(button: sender, playTap: false, play: optionMusic)
        
        if (gameModel.getDifficult()==Difficulty.Unfair){
            gameModel.changeCurrentConf()
            setButtonColors()
        }
    }
    
    //Set Button from GameController EnumValues
    private func setButtonColors() {
        var i = 0
        for b in gameModel.getCurrentConf(){
            buttonContainer[i].backgroundColor = Modelator.convertEnumValueToColor(enumValue: b)
            i += 1
        }
    }
    
    private func produceVibration(evaluation: Bool){
        if !optionVibration {
            return
        }
        
        if !evaluation{
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
    //Create timer
    private func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    //Update Score label
    private func updateScoreLabel(){
        label_Score.text = String(gameModel.getScore())
    }
    //Update Timer Label
    @objc private func updateTimer() {
        label_Timer.text = String(tick)
        tick = tick - 1
        
        if (tick % refreshInterval == 0) {
            gameModel.changeCurrentConf()
            setButtonColors()
        }
        if (tick == -1) {
            gameModel.endOfGame()
            timer!.invalidate()
            changeView()
        }
    }
    
    private func changeView(){
        updateScoreValue()
        performSegue(withIdentifier: "segue_PlayToGameOver", sender: nil)
    }
}

