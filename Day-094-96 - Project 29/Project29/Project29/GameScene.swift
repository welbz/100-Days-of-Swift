//
//  GameScene.swift
//  Project29
//
//  Created by Welby Jennings on 2/10/20.
//  https://www.hackingwithswift.com/100/94
    // Video 2 - https://www.hackingwithswift.com/read/29/2/building-the-environment-sktexture-and-filling-a-path
    // Video 3 - https://www.hackingwithswift.com/read/29/3/mixing-uikit-and-spritekit-uislider-and-skview
    // Video 4 -

import SpriteKit

// 1 - Video 2
enum CollisionTypes: UInt32 {
    case banana = 1
    case building = 2
    case player = 4
}

class GameScene: SKScene {
    var builings = [BuildingNode]()
    weak var viewConroller: GameViewController? // 6 - Video 3
    
    // 12 - Video 4
    var player1: SKSpriteNode!
    var player2: SKSpriteNode!
    var banana: SKSpriteNode!
    
    var currentPlayer = 1
    
    
    override func didMove(to view: SKView) {
        // 4 - Video 2
        backgroundColor = UIColor(hue: 0.669, saturation: 0.99, brightness: 0.67, alpha: 1)
        
        createBuildings()
        // move horiz of screen filling it with buildings
    }
    
    // 5 - Video 2
    func createBuildings() {
        var currentX: CGFloat = -15 // just off screen
        
        while currentX < 1024 {
            let size = CGSize(width: Int.random(in: 2...4) * 40, height: Int.random(in: 300...600))
            currentX += size.width + 2 // move along x value + 2 more
            
            let building = BuildingNode(color: .red, size: size)
            building.position = CGPoint(x: currentX - (size.width / 2), y: size.height / 2)
            // move half of width
            building.setup()
            addChild(building)
        }
    }
    
    func launch(angle: Int, velocity: Int) {
        
    }
    
    // 13 - Video 4
    func createPlayers() {
        player1 = SKSpriteNode(imageNamed: "player")
        player1.name = "player1"
        player1.physicsBody = SKPhysicsBody(circleOfRadius: player1.size.width / 2)
        
        player1.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
        player1.physicsBody?.collisionBitMask = CollisionTypes.banana.rawValue // bounce off bananas
        player1.physicsBody?.contactTestBitMask = CollisionTypes.banana.rawValue // tell us about collision types banana
        player1.physicsBody?.isDynamic = false // dont let them be moved
    }
}
