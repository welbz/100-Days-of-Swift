//
//  GameScene.swift
//  Project26
//
//  Created by Welby Jennings on 20/9/20.
//
// https://www.hackingwithswift.com/100/85
// Video 2 -https://www.hackingwithswift.com/read/26/2/loading-a-level-categorybitmask-collisionbitmask-contacttestbitmask

import SpriteKit

// 2 - Video 2
enum CollisionTypes: UInt32 {
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case finish = 16
} // Numbers double so we can combine the numbers without them colliding with other existing values

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        // 3 - Video 2
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        loadLevel()
    }
    
    // 1 - Video 2
    func loadLevel() {
        // try and get file from bundle or bail out
        guard let levelURL = Bundle.main.url(forResource: "level1", withExtension: "txt") else {
            // use fatalError instead of return
        fatalError("Could not find level1.txt in app bundle")
        }
        // load string from file or bail out
        guard let levelString = try? String(contentsOf: levelURL) else {
            fatalError("Could not load level1.txt from app bundle")
        }
        
        // split into lines by \n
        let lines = levelString.components(separatedBy: "\n")
        
        // loop over all lines from file in reverse to get our rows, then inside there loop over all the rows letter by letter to get columns
        for (row, line) in lines.reversed().enumerated() {
            for (column, letter) in line.enumerated() {
                let position = CGPoint(x: (64 * column) + 32, y: (64 * row + 32))
          
        // creating elements of level
                if letter == "x" {
                    //load wall
                    let node = SKSpriteNode(imageNamed: "block")
                    node.position = position
                    
                    node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                    node.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
                    node.physicsBody?.isDynamic = false
                    
                    addChild(node)
                } else if letter == "v" {
                    //load vortex
                    let node = SKSpriteNode(imageNamed: "vortex")
                    node.name = "vortex"
                    node.position = position
                    node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1))) //spin 180 every second
                    
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false
                    
                    node.physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    
                    addChild(node)
                } else if letter == "s" {
                    //load star
                    let node = SKSpriteNode(imageNamed: "star")
                    node.name = "star"
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false
                    
                    node.physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    node.position = position
                    
                    addChild(node)
                } else if letter == "f" {
                    //load finish
                    let node = SKSpriteNode(imageNamed: "finish")
                    node.name = "finish"
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false
                    
                    node.physicsBody?.categoryBitMask = CollisionTypes.finish.rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    node.position = position
                    
                    addChild(node)
                } else if letter == " " {
                    // if this is an empty space - do nothing
                } else {
                    fatalError("Unkown level letter: \(letter)")
                }
            }
        }
    }
}

