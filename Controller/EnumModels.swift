//
//  EnumModels.swift
//  TapMania
//
//  Created by Marco Cardoso on 11/19/18.
//  Copyright © 2018 MCG_CODE. All rights reserved.
//

import Foundation

//Enum used for segue transitions
enum gameMenu : String {
    case Play = "segue_MainMenuToPlay"
    case Settings = "segue_MainMenuToSettings"
    case Records = "segue_MainMenuToRecords"
    case Difficult = "segue_MainMenuToDifficult"
}

//Enum used to select the proper audio player
enum audioPlayer {
    case Menu
    case InGame
    case Tap
}
