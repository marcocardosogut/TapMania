//
//  ModelatorController.swift
//  TapMania
//
//  Created by Marco Cardoso on 11/16/18.
//  Copyright © 2018 MCG_CODE. All rights reserved.
//

import Foundation
import UIKit

public class Modelator {
    
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
    
    //Round Button Corners
    static func formatButton(buttons: [UIButton]){
        for b in buttons {
            b.layer.cornerRadius = 0.5 * b.frame.size.height
            b.layer.shadowColor = UIColor.black.cgColor
            b.layer.shadowOffset = CGSize(width: 5, height: 5)
            b.layer.shadowRadius = 5
            b.layer.shadowOpacity = 1.0
        }
    }
    
    static func formatButtonBack(button: UIButton){
        let height = UIScreen.main.bounds.height
        let widht  = UIScreen.main.bounds.width
        button.frame = CGRect(x: 0, y: 0, width: widht, height: height)
    }
    
    
    static func buttonPressAnimation (button: UIButton) {
        UIButton.animate(withDuration: 0.01,
                         animations:{button.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)},
                         completion:{ finish in UIButton.animate(withDuration: 0.01,
                                                                 animations: {button.transform = CGAffineTransform.identity})})
    }
    
}
