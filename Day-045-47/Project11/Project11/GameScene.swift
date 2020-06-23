//
//  GameScene.swift
//  Project11
//
//  Created by Welby Jennings on 22/6/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    var scoreLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editLabel: SKLabelNode!
    
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        // Create scoreLabel and add to screen
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        // Create editLabel and add to screen
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        // physics
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        // slot in front
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return } // first touches on screen
        let location = touch.location(in: self) // where touch happened in whole scene
        let object = nodes(at: location)
        
        if object.contains(editLabel) {
            // editingMode = !editingMode - better to use toggle
            editingMode.toggle()
        } else {
            if editingMode { // if in editing mode create box
                // create box
                let size = CGSize(width: Int.random(in: 16...128), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                // random red green blue
                box.zRotation = CGFloat.random(in: 0...3)
                box.position = location
                
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.isDynamic = false // dont allow it to move
                addChild(box) // add tp game scene
                
            } else {
                let ball = SKSpriteNode(imageNamed: "ballRed")
                
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0) // behaves as balls not squares
                ball.physicsBody?.restitution = 0.4 // bouncy-ness (optional)
                
                // collisionBitMask - bounch off everything
                // contactTestBitMask - tell us every bounch it has
                ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask
                    ?? 0 // nil coalescing
                
                ball.position = location // sets postion at location of touch
                ball.name = "ball"
                addChild(ball) // calls in
            }
        }
        
    }
    
    
    // makeBouncer
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2) //
        bouncer.physicsBody?.isDynamic = false
        // when true object moved based on gravity and collisions
        // false it will be fixed in place
        addChild(bouncer) // calls in
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size) // rectangle the size of slotBase base
        slotBase.physicsBody?.isDynamic = false // Dont want them to move on collision
        
        addChild(slotBase) //added to game scene
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10) //10 seconds to spin half cicle
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    // SKNode is the parent class
    func collision(between ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
        }
    }
    
    func destroy(ball: SKNode) {
        ball.removeFromParent() // Removed node from node tree
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // safe guards us in case of collision issues
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            collision(between: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collision(between: nodeB, object: nodeA)
        }
    }
}
