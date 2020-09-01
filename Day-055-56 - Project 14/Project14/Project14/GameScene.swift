//
//  GameScene.swift
//  Project14
//
//  Created by Welby Jennings on 27/7/20.
//

import SpriteKit



class GameScene: SKScene {
    var gameScore: SKLabelNode!
    var finalGameScore: SKLabelNode!
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    var slots = [WhackSlot]() // array to store all slots
    var popupTime = 0.85
    var numRounds = 0
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        
        // For loops to create slots
        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 410)) }
        for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 320)) }
        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 230)) }
        for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 140)) }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.createEnemy() // calls itself
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self) // where they tap screen
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes {
            // See notes below - read grandparent of thing that was tapped
            guard let whackSlot = node.parent?.parent as? WhackSlot else { continue }
            
            if !whackSlot.isVisible { continue }
            if whackSlot.isHit { continue }
            
            whackSlot.hit()
            
            if node.name == "charFriend" {
                // they shoudnt have whacked the pengiun
                score -= 5
                run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
            } else if node.name == "charEnemy" {
                // they should have whacked this one
                whackSlot.charNode.xScale = 0.85 // makes them slightly smaller in size
                whackSlot.charNode.yScale = 0.85 // makes them slightly smaller in size
                score += 1
                run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion:false))
            }
        }
    }
    
    // func to create the slots
    func createSlot(at position: CGPoint) {
        let slot = WhackSlot()
        slot.configure(at: position)
        addChild(slot)
        slots.append(slot)
    }
    
    func createEnemy() {
        numRounds += 1
        
        if numRounds >= 30 {
            for slot in slots {
                slot.hide()
            }
            
            let gameOver = SKSpriteNode(imageNamed: "gameOver")
            gameOver.position = CGPoint(x: 512, y: 384)
            gameOver.zPosition = 1
            addChild(gameOver)
            
            
            
            // MARK: - Project 14 Challenge 2
            finalGameScore = SKLabelNode(fontNamed: "SF Pro Display")
            finalGameScore.text = "Your Final Score: \(score)"
            finalGameScore.position = CGPoint(x: 512, y: 260)
            finalGameScore.horizontalAlignmentMode = .center
            finalGameScore.fontSize = 60
            addChild(finalGameScore)
            
            // MARK: - Project 14 Challenge 1
            // Record your own voice saying "Game over!" and have it play when the game ends.
            //run(SKAction.playSoundFileNamed("gameover.caf", waitForCompletion: false))
            
            return // stop calling create enemy now
        }
        
        
        popupTime *= 0.991
        
        slots.shuffle()
        slots[0].show(hideTime: popupTime)
        
        if Int.random(in: 0...12) > 4 { slots[1].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 8 { slots[2].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 10 { slots[3].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 11 { slots[4].show(hideTime: popupTime) } // rare
        
        let minDelay = popupTime / 2.0
        let maxDelay = popupTime * 2
        let delay = Double.random(in: minDelay...maxDelay)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.createEnemy() // calls itself
        }
    }
}

/*
 guard let whackSlot = node.parent?.parent as? WhackSlot else { continue }
 
 It gets the parent of the parent of the node, and typecasts it as a WhackSlot. This line is needed because the player has tapped the penguin sprite node, not the slot – we need to get the parent of the penguin, which is the crop node it sits inside, then get the parent of the crop node, which is the WhackSlot object, which is what this code does.
 */
