//
//  GameScene.swift
//  Project20
//
//  Created by Welby Jennings on 5/9/20.
//  https://www.hackingwithswift.com/100/70
// https://www.hackingwithswift.com/read/20/1/setting-up
// https://www.hackingwithswift.com/read/20/2/ready-aim-fire-timer-and-follow
// https://www.hackingwithswift.com/read/20/3/swipe-to-select

//  https://www.hackingwithswift.com/100/71
// https://www.hackingwithswift.com/read/20/4/making-things-go-bang-skemitternode


import SpriteKit

class GameScene: SKScene {
    var gameTimer: Timer?
    var fireworks = [SKNode]()
    
    let leftEdge = -22
    let bottomEdge = -22
    let rightEdge = 1024 + 22
    
    var score = 0 {
        didSet {
            // score labelnode code - changes text when score changes
        }
    }
    
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1 // behind others on scene
        addChild(background)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(launchFireworks), userInfo: nil, repeats: true)
        
        
    }
    
    func createFirework(xMovement: CGFloat, x:Int, y:Int) {
        let node = SKNode()
        node.position = CGPoint(x: x, y: y)
        
        let firework = SKSpriteNode(imageNamed: "rocket")
        firework.colorBlendFactor = 1
        firework.name = "firework"
        node.addChild(firework) //add to node
        
        // Original rocket is white so we assign a random colour
        switch Int.random(in: 0...2) {
        case 0:
            firework.color = .cyan
        case 1:
            firework.color = .green
        default:
            firework.color = .red
        }
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: xMovement, y: 1000)) // path to follow
        
        let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
        node.run(move)
        
        if let emitter = SKEmitterNode(fileNamed: "fuse") {
            emitter.position = CGPoint(x: 0, y: -22) // behind rocket
            node.addChild(emitter)
        }
        
        // Add to game scene and add it to our fireworks array
        fireworks.append(node)
        addChild(node)
    }
    
    //Launch 5 Fireworks
    @objc func launchFireworks() {
        let movementAcount: CGFloat = 1800
        
        switch Int.random(in: 0...3) {
        case 0:
            // fire 5 stright up
            createFirework(xMovement: 0, x: 512, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 - 200, y: bottomEdge) // off to left
            createFirework(xMovement: 0, x: 512 - 100, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 + 100, y: bottomEdge) // off to right
            createFirework(xMovement: 0, x: 512 + 200, y: bottomEdge)
        case 1:
            // fire 5 in a fan
            createFirework(xMovement: 0, x: 512, y: bottomEdge)
            createFirework(xMovement: -200, x: 512 - 200, y: bottomEdge)
            createFirework(xMovement: -100, x: 512 - 100, y: bottomEdge)
            createFirework(xMovement: 100, x: 512 + 100, y: bottomEdge)
            createFirework(xMovement: 200, x: 512 + 200, y: bottomEdge)
        case 2:
            // fire 5 from left to right
            createFirework(xMovement: movementAcount, x: leftEdge, y: bottomEdge + 400)
            createFirework(xMovement: movementAcount, x: leftEdge, y: bottomEdge + 300)
            createFirework(xMovement: movementAcount, x: leftEdge, y: bottomEdge + 200)
            createFirework(xMovement: movementAcount, x: leftEdge, y: bottomEdge + 100)
            createFirework(xMovement: movementAcount, x: leftEdge, y: bottomEdge)
        case 3:
            // fire 5 from right to left
            createFirework(xMovement: movementAcount, x: rightEdge, y: bottomEdge + 400)
            createFirework(xMovement: movementAcount, x: rightEdge, y: bottomEdge + 300)
            createFirework(xMovement: movementAcount, x: rightEdge, y: bottomEdge + 200)
            createFirework(xMovement: movementAcount, x: rightEdge, y: bottomEdge + 100)
            createFirework(xMovement: movementAcount, x: rightEdge, y: bottomEdge)
        default:
            break
        }
    }
    
    func checkTouches(_ touches:Set<UITouch>) {
        guard let touch = touches.first else { return } // if not touch bail out
        
        // Where was touch
        let location = touch.location(in: self)
        
        let nodesAtPoint = nodes(at: location)
        
        // find all SpriteNodes that are fireworks
        // cannot use colorBlendFactor
        for case let node as SKSpriteNode in nodesAtPoint {
            guard node.name == "firework" else { continue } // get out of loop if its not firework
            
            for parent in fireworks {
                guard let firework = parent.children.first as? SKSpriteNode else { continue }
                
                if firework.name == "selected" && firework.color != node.color {
                    firework.name = "firework"
                    firework.colorBlendFactor = 1 // back to default colour
                }
            }
            
            node.name = "selected"
            node.colorBlendFactor = 0 // default colour of white
        }
        
        // for case let
        /*
         This lets us attempts some work (typecasting to SKSpriteNode in this case), and run the loop body only for items that were successfully typecast
         
         The let node part creates a new constant called node, the case…as SKSpriteNode part means “if we can typecast this item as a sprite node, and of course the for loop is the loop itself.
         */
    }
    
    // Send touch info on check touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        checkTouches(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        checkTouches(touches)
    }
    
    // remove items from array backwards
    override func update(_ currentTime: TimeInterval) {
        // loop over all fireworks and reverse whole thing
        for (index, firework) in fireworks.enumerated().reversed() {
            if firework.position.y > 900 {
                fireworks.remove(at: index)
                firework.removeFromParent() // get out of game scene
            }
        }
    }
    
    /*
     We need to create:
     a method to explode a single firework
     a method to explode all the fireworks (which will call the single firework explosion method)
     code to detect and respond the device being shaken.
     */
    
    func explode(firework: SKNode) {
        if let emmitter = SKEmitterNode(fileNamed: "explode") {
            emmitter.position = firework.position
            addChild(emmitter)
        }
        
        firework.removeFromParent()
    }
    
    
    func explodeFireworks() {
        var numExploded = 0
        
        for (index, fireworkContainer) in fireworks.enumerated().reversed() {
            guard let firework = fireworkContainer.children.first as?
                    SKSpriteNode else { continue }
            
            if firework.name == "selected" {
                explode(firework: fireworkContainer)
                fireworks.remove(at: index) // remove from array
                numExploded += 1
            }
        }
        
        // switch based on how many explosions user gets
        switch numExploded {
        case 0:
            break
        case 1:
            score += 200
        case 2:
            score += 500
        case 3:
            score += 1_500
        case 4:
            score += 2_500
        default:
            score += 4_000
        }
    }
}



// MARK: - Note
/*
 The explodeFireworks() method is only fractionally more complicated. It will be triggered when the user wants to set off their selected fireworks, so it needs to loop through the fireworks array (backwards again!), pick out any selected ones, then call explode() on it.
 
 As I said earlier, the player's score needs to go up by more when they select more fireworks, so about half of the explodeFireworks() method is taken up with figuring out what score to give the player.
 
 There's one small piece of extra complexity: remember, the fireworks array stores the firework container node, so we need to read the firework image out of its children array.
 */
