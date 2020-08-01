//
//  WhackSlot.swift
//  Project14
//
//  Created by Welby Jennings on 27/7/20.
//

import SpriteKit // need to import
import UIKit

// Node - tree of nodes
class WhackSlot: SKNode {
    var charNode: SKSpriteNode!
    
    var isVisible = false
    var isHit = false
    
    // hold other Nodes as children
    func configure(at position: CGPoint) {
        self.position = position
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask") //crops with mask image
        
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90) //-90 to hide
        charNode.name = "character"
        cropNode.addChild(charNode)
        // cropNode only crops things inside it.
        
        addChild(cropNode)
    }
    
    // Show penguins
    func show(hideTime: Double) {
        if isVisible { return } // dont show again if visible
        
        charNode.xScale = 1 // set to normal size
        charNode.yScale = 1 // set to normal size
        
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        isVisible = true // is visible
        isHit = false // not hit yet
        
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        
        // MARK: - Project 14 Challenge 3b
        if let muddyPenguins = SKEmitterNode(fileNamed: "muddyPenguins") {
            addChild(muddyPenguins)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) {
            [weak self] in
            self?.hide()
        }
    }
    
    func hide() {
        if !isVisible { return }
        
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        
        // MARK: - Project 14 Challenge 3b
        if let muddyPenguins = SKEmitterNode(fileNamed: "muddyPenguins") {
            addChild(muddyPenguins)
        }
        
        isVisible = false
    }
    
    func hit() {
        isHit = true
        
        let delay = SKAction.wait(forDuration: 0.25)
        let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
        let notVisible = SKAction.run { [weak self] in self?.isVisible = false }
        let sequence = SKAction.sequence([delay, hide, notVisible])
        charNode.run(sequence)
        
        // MARK: - Project 14 Challenge 3a
        if let smokeyPenguins = SKEmitterNode(fileNamed: "smokeyPenguins") {
            //smokeyPenguins.position = charNode.position
            addChild(smokeyPenguins)
        }
    }
}

/*
 the character node is added to the crop node
 the crop node was added to the slot.
 
 This is because the crop node only crops nodes that are inside it, so we need to have a clear hierarchy: the slot has the hole and crop node as children, and the crop node has the character node as a child.
 */
