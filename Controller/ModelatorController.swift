//
//  ModelatorController.swift
//  TapMania
//
//  Created by Marco Cardoso on 11/16/18.
//  Copyright © 2018 MCG_CODE. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit


public class Modelator {
    //Store 3 Players, Menu Music, In Game, and Sound Effects
    static var audioPlayers : [AVAudioPlayer] = [AVAudioPlayer(), AVAudioPlayer(), AVAudioPlayer()]
    
    //Convert Color to EnumValue
    static func convertColorToEnumValue(color: UIColor)->BallValue {
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
    static func convertEnumValueToColor(enumValue : BallValue)->UIColor {
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
    
    //Convert an array of buttons in to round buttons with shadows effect
    static func formatButton(buttons: [UIButton]){
        for b in buttons {
            b.layer.cornerRadius = 0.5 * b.frame.size.height
            b.layer.shadowColor = UIColor.black.cgColor
            b.layer.shadowOffset = CGSize(width: 5, height: 5)
            b.layer.shadowRadius = 5
            b.layer.shadowOpacity = 1.0
        }
    }
    
    //Format the back button to the entire with of the display
    static func formatButtonBack(button: UIButton){
        let height = UIScreen.main.bounds.height
        let widht  = UIScreen.main.bounds.width
        button.frame = CGRect(x: 0, y: 0, width: widht, height: height)
    }
    
    //Play the visual animation and sound when a button is pressed
    static func buttonPressAnimation (button: UIButton, playTap: Bool) {
        UIButton.animate(withDuration: 0.01,
                         animations:{button.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)},
                         completion:{ finish in UIButton.animate(withDuration: 0.01,
                                                                 animations: {button.transform = CGAffineTransform.identity})})
        if(playTap){
            playAudio(player: .Tap)
        }
    }
    
    static func loadAudioPlayers(){
        do {
            audioPlayers[0] = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "menuMusic", ofType: "wav")!))
            audioPlayers[0].prepareToPlay()
            audioPlayers[0].numberOfLoops = -1
        } catch let error {
            print(error.localizedDescription)
        }
        
        do {
            audioPlayers[1] = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "inGameMusic", ofType: "mp3")!))
            audioPlayers[1].prepareToPlay()
        } catch let error {
            print(error.localizedDescription)
        }
        
        do {
            audioPlayers[2] = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "tap", ofType: "wav")!))
            audioPlayers[2].prepareToPlay()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //Play an audio corresponding with the received audioPlayer
    static func playAudio(player: audioPlayer){
        switch player {
        case .Menu:
            if(!audioPlayers[0].isPlaying){
                audioPlayers[0].play()
            }
        case .InGame:
            audioPlayers[0].stop()
            audioPlayers[1].play()
        case .Tap:
            audioPlayers[2].play()
        }
    }
    
    //Check if the current device is a generation between 5s and 8+
    static func detectHomeButtonModel ()->Bool{
        let oldModels = ["SE","5","6","7","8"]
        for models in oldModels{
            if(UIDevice.current.name.contains(models)){
                return true
            }
        }
        return false
    }
}
