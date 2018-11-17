//
//  GameTapMania.swift
//  TapMania
//
//  Created by Marco Cardoso on 11/2/18.
//  Copyright © 2018 MCG_CODE. All rights reserved.
//

import Foundation

enum BallValue :Int {
    case Empty = -1
    case Green = 0
    case Red = 1
    case Orange = 2
    case Blue = 3
}

enum Difficulty : Int {
    case Easy = 0
    case Medium = 1
    case Hard = 2
    case Unfair = 3
}

class GameTapMania {
    private var score :Int
    private var _endOfGame = false
    private let _difficult : Difficulty
    private var currentConf : [BallValue]
    
    init(difficult: Difficulty){
        _difficult = difficult
        score = 0
        currentConf = [BallValue.Blue,BallValue.Green,BallValue.Red,BallValue.Orange,BallValue.Blue]
        changeCurrentConf()
    }
    
    public func getDifficult() -> Difficulty{
        return _difficult
    }
    
    public func getScore()->Int {
        return score;
    }
    
    public func getCurrentConf()->[BallValue] {
        return currentConf
    }
    
    public func evaluate(played : BallValue) ->Bool {
        if(_endOfGame) {
            return false
        }
        if(played == currentConf[4]) {
            increaseScore()
            return true
        }
        else{
            decreaseScore()
            return false
        }
    }
    
    private func increaseScore() {
        score = score + 1;
    }
    
    private func decreaseScore() {
        if score > 0 {
            score = score - 1
        }
    }
    
    public func changeCurrentConf() {
        if _endOfGame {
            return
        }
        switch _difficult {
        case .Easy:
            changeConfProbapility(probrability: 0)
        case .Medium:
            changeConfProbapility(probrability: 3)
        case .Hard:
            changeConfProbapility(probrability: 7)
        case .Unfair:
           changeConfProbapility(probrability: 11)
        }
    }
    
    private func changeConfProbapility(probrability: Int) {
        let random = Int.random(in: 0..<10)
        if random>=probrability {
            currentConf[4] = currentConf.prefix(4).randomElement()!
        } else {
            var newConf = currentConf.prefix(4)
            newConf.shuffle()
            newConf.append(newConf.randomElement()!)
            var i = 0
            for t in newConf {
                currentConf[i] = t
                i += 1
            }
        }
    }
    
    public func endOfGame() {
        _endOfGame = true
    }
    
    public func gameOver() -> Bool {
        return _endOfGame
    }
}
