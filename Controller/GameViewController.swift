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
    var gameController = GameTapMania(difficult: Difficulty.Unfair)
    let colors = [#colorLiteral(red: 0.9996238351, green: 0.1655850112, blue: 0.3347808123, alpha: 1),#colorLiteral(red: 0.3477838635, green: 0.7905586958, blue: 0.9795156121, alpha: 1),#colorLiteral(red: 0.9993136525, green: 0.5816664696, blue: 0.001078070956, alpha: 1),#colorLiteral(red: 0.2870728374, green: 0.8392896056, blue: 0.3857751787, alpha: 1)]
    var tick = 60
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
    //********* END VISUAL CONTROLERS *********
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonContainer = [button_TL,button_BL,button_TR,button_BR,button_C]
        formatButton(buttons: buttonContainer)
        setButtonColors()
        runTimer()
    }
    
    //********* ACTIONS *********
    @IBAction func button_Press(_ sender: UIButton) {
        let t = convertColorToEnumValue(color: sender.backgroundColor!)
        produceVibration(evaluation: gameController.evaluate(played: t))
        updateScore()
        buttonPressAnimation(button: sender)
    }
    //********* END ACTIONS *********
    
    //********* AUXILIARS *********
    
    //_______________________INTERPRETS
    //Convert Color to EnumValue
    private func convertColorToEnumValue(color: UIColor)->BallValue {
        switch color {
        case #colorLiteral(red: 0.9996238351, green: 0.1655850112, blue: 0.3347808123, alpha: 1):
            return BallValue.Red
        case #colorLiteral(red: 0.3477838635, green: 0.7905586958, blue: 0.9795156121, alpha: 1):
            return BallValue.Blue
        case #colorLiteral(red: 0.9993136525, green: 0.5816664696, blue: 0.001078070956, alpha: 1):
            return BallValue.Orange
        case #colorLiteral(red: 0.2870728374, green: 0.8392896056, blue: 0.3857751787, alpha: 1):
            return BallValue.Green
        default:
            print("Error: Invalid color selection @convertColorToEnumValue. Default executed")
        }
        return BallValue.Empty
    }
    
    //Convert EnumValue to Color
    private func convertEnumValueToColor(enumValue : BallValue)->UIColor {
        switch enumValue {
        case BallValue.Red:
            return #colorLiteral(red: 0.9996238351, green: 0.1655850112, blue: 0.3347808123, alpha: 1)
        case BallValue.Blue:
            return #colorLiteral(red: 0.3477838635, green: 0.7905586958, blue: 0.9795156121, alpha: 1)
        case BallValue.Orange:
            return #colorLiteral(red: 0.9993136525, green: 0.5816664696, blue: 0.001078070956, alpha: 1)
        case BallValue.Green:
            return #colorLiteral(red: 0.2870728374, green: 0.8392896056, blue: 0.3857751787, alpha: 1)
        default:
            print("Error: Invalid enum selection @convertEnumValueToColor. Default executed")
        }
        return #colorLiteral(red: 0.2870728374, green: 0.8392896056, blue: 0.3857751787, alpha: 1)
    }
    
    //Set Button from GameController EnumValues
    private func setButtonColors() {
        var i = 0
        for b in gameController.getCurrentConf(){
            buttonContainer[i].backgroundColor = convertEnumValueToColor(enumValue: b)
            i += 1
        }
    }
    //_______________________END_INTERPRETS
    
    //_______________________VISUAL
    
    private func produceVibration(evaluation: Bool){
        if !evaluation{
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
    
    //Round Button Corners
    private func formatButton(buttons: [UIButton]){
        for b in buttons{
            b.layer.cornerRadius = 0.5 * b.frame.size.height
            b.layer.shadowColor = UIColor.black.cgColor
            b.layer.shadowOffset = CGSize(width: 5, height: 5)
            b.layer.shadowRadius = 5
            b.layer.shadowOpacity = 1.0
        }
    }
    
    private func buttonPressAnimation (button: UIButton) {
        UIButton.animate(withDuration: 0.01,
                        animations:{button.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)},
                        completion:{ finish in UIButton.animate(withDuration: 0.01,
                                                                animations: {button.transform = CGAffineTransform.identity})})
    }
    
    //Create timer
    private func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    //Update Score label
    private func updateScore(){
        label_Score.text = String(gameController.getScore())
    }
    //Update Timer Label
    @objc private func updateTimer() {
        label_Timer.text = String(tick)
        tick = tick - 1
        
        if (tick % 3 == 0) {
            gameController.changeCurrentConf()
            setButtonColors()
        }
        if (tick == -1) {
            gameController.endOfGame()
            timer!.invalidate()
            performSegue(withIdentifier: "segue_PlayToGameOver", sender: nil)
        }
    }
    
    //_______________________END_VISUAL
    
    //********* END AUXILIARS *********


}

