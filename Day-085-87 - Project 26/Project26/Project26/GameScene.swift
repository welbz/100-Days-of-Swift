//
//  GameScene.swift
//  Project26
//
//  Created by Welby Jennings on 20/9/20.
//
// https://www.hackingwithswift.com/100/85
// Video 2 - https://www.hackingwithswift.com/read/26/2/loading-a-level-categorybitmask-collisionbitmask-contacttestbitmask
// Video 3 -


import CoreMotion
import SpriteKit

// 2 - Video 2
enum CollisionTypes: UInt32 {
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case finish = 16
} // Numbers double so we can combine the numbers without them colliding with other existing values

class GameScene: SKScene, SKPhysicsContactDelegate {
    // 4 - Video 3
    var player: SKSpriteNode!
    
    // Only for simulator
    var lastTouchPosition: CGPoint?
    
    // 7 - Video 3
    var motionManager: CMMotionManager? // CMMotionManager needs import CoreMotion
    
    // 12 - Video 3
    var isGameOver = false
    
    // 8 - Video 4
    var scoreLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    
    override func didMove(to view: SKView) {
        // 3 - Video 2
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        // 9 - Video 4
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
        
        
        loadLevel()
        
        // 6 - Video 3
        createPlayer()
        physicsWorld.gravity = .zero
        
        // 10 - Video 3
        // Tell us when collision
        // First, we need to make ourselves the contact delegate for the physics world, so make your class conform to SKPhysicsContactDelegate in import above
        physicsWorld.contactDelegate = self
        
        // 8 - Video 3
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates() // start collecting Accelerometer tilt info
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
    
    // 5 - Video 3
    func createPlayer() {
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 96, y: 672)
        player.zPosition = 1
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.linearDamping = 0.5

        player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
        player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue | CollisionTypes.vortex.rawValue | CollisionTypes.finish.rawValue
        player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
        
        addChild(player)
    }
    
    // All only for simulator
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPosition = nil
    }
    
    // See Notes
    override func update(_ currentTime: TimeInterval) {
        guard isGameOver == false else { return } // when game is over dont let them control game
        
        #if targetEnvironment(simulator)
        if let currentTouch = lastTouchPosition {
            let diff = CGPoint(x: currentTouch.x - player.position.x, y: currentTouch.y - player.position.y)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
        #else
        // tilt info - has gentle values so we need to multiple by dx -50 and dy 50
        if let accelerometerData = motionManager?.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
        #endif
    }
        // 11 - Video 4
        // Collisions
        func didBegin(_ contact: SKPhysicsContact) {
            guard let nodeA = contact.bodyA.node else { return }
            guard let nodeB = contact.bodyB.node else { return }

            if nodeA == player {
                playerCollided(with: nodeB)
            } else if nodeB == player {
                playerCollided(with: nodeA)
            }
        }
    
    
    func playerCollided(with node: SKNode) {
        // when ball moves over vortex -  See notes Collisions with Vortex
        if node.name == "vortex" {
            player.physicsBody?.isDynamic = false
            isGameOver = true
            score -= 1

            let move = SKAction.move(to: node.position, duration: 0.25)
            let scale = SKAction.scale(to: 0.0001, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, scale, remove])

            player.run(sequence) { [unowned self] in
                self.createPlayer()
                self.isGameOver = false
            }
        } else if node.name == "star" {
            node.removeFromParent()
            score += 1
        } else if node.name == "finish" {
            // go to next level
        }
    }
}
