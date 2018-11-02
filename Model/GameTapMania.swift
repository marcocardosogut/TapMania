//
//  GameTapMania.swift
//  TapMania
//
//  Created by Marco Cardoso on 11/2/18.
//  Copyright © 2018 MCG_CODE. All rights reserved.
//

import Foundation

enum BallValue :Int
{
    case Empty = -1
    case Green = 0
    case Red = 1
    case Orange = 2
    case Blue = 3
}

enum Difficulty
{
    case Easy
    case Medium
    case Hard
    case Unfair
}

class GameTapMania
{
    private var score :Int
    private var _endOfGame = false
    private let _difficult : Difficulty
    private var currentConf : [BallValue]
    init(difficult: Difficulty)
    {
        _difficult = difficult
        score = 0
        currentConf = [BallValue.Blue,BallValue.Green,BallValue.Red,BallValue.Orange,BallValue.Blue]
        changeCurrentConf()
    }
    
    public func getScore()->Int
    {
        return score;
    }
    
    public func getCurrentConf()->[BallValue]
    {
        return currentConf
    }
    
    public func evaluate(played : BallValue)
    {
        if(_endOfGame)
        {
            return
        }
        if(played == currentConf[4])
        {
            increaseScore()
        }
        else
        {
            decreaseScore()
        }
    }
    
    private func increaseScore()
    {
        score = score + 1;
    }
    
    private func decreaseScore()
    {
        if score > 0
        {
            score = score - 1
        }
    }
    
    public func changeCurrentConf()
    {
        if _endOfGame
        {
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
    
    private func changeConfProbapility(probrability: Int)
    {
        let random = Int.random(in: 0..<10)
        if random<probrability
        {
            for var ball in currentConf
            {
                ball = randomBall(actualValue: ball)
            }
        }
        else
        {
            currentConf[4] = randomBall(actualValue: currentConf[4])
        }
    }
    
    private func randomBall(actualValue: BallValue)->BallValue
    {
        var temp = [BallValue]()
        for t in currentConf
        {
            if t != actualValue
            {
                temp.append(t)
            }
        }
        return temp.randomElement()!
    }
    
    public func endOfGame()
    {
        _endOfGame = true
    }
    
    public func gameOver() -> Bool
    {
        return _endOfGame
    }
}
