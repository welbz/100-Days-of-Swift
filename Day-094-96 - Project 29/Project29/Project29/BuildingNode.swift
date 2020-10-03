//
//  BuildingNode.swift
//  Project29
//
//  Created by Welby Jennings on 2/10/20.
//

import SpriteKit
import UIKit

/*
 Initially, this class needs to have three methods:
 
 setup() will do the basic work required to make this thing a building: setting its name, texture, and physics.
 
 configurePhysics() will set up per-pixel physics for the sprite's current texture.
 
 drawBuilding() will do the Core Graphics rendering of a building, and return it as a UIImage.
 */



class BuildingNode: SKSpriteNode {
    // 1 - Video 2
    var currentImage: UIImage!
    
    func setup() {
        name = "building"
        
        currentImage = drawBuilding(size: size)
        texture = SKTexture(image: currentImage)
        
        configurePhysics()
        
    }
    
    // 2 - Video 2
    func configurePhysics() {
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        physicsBody?.isDynamic = false // dont move
        physicsBody?.categoryBitMask = CollisionTypes.building.rawValue
        physicsBody?.contactTestBitMask = CollisionTypes.banana.rawValue
    } // create a new core graphic context, building, fill with colour, lights on or off, colour and pull result of out UI image and retun it for use
    
    
    // 3 - Video 2
    // renders UIImage and stashes it away in the current image property and uses that as the texture of the building
    func drawBuilding(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x:0, y: 0, width: size.width, height: size.height)
            
            let colour: UIColor
            
            switch Int.random(in: 0...2) {
            case 0:
                colour = UIColor(hue: 0.502, saturation: 0.98, brightness: 0.67, alpha: 1)
                
            case 1:
                colour = UIColor(hue: 0.999, saturation: 0.99, brightness: 0.67, alpha: 1)
                
            default:
                colour = UIColor(hue: 0, saturation: 0, brightness: 0.67, alpha: 1)
            }
            
            // fill in the building shape in image
            colour.setFill()
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fill) // not .stroke
            
            // lights in building
            let lightOnColour = UIColor(hue: 0.19, saturation: 0.67, brightness: 0.99, alpha: 1)
            let lightOffColour = UIColor(hue: 0, saturation: 0, brightness: 0.34, alpha: 1)
            
            // nested loop over lights in building
            for row in stride(from: 10, to: Int(size.height - 10), by: 40) {
                for col in stride(from: 10, to: Int(size.width - 10), by: 40) {
                    if Bool.random() { // awesome
                        lightOnColour.setFill()
                    } else {
                        lightOffColour.setFill()
                    }
                    
                    ctx.cgContext.fill(CGRect(x: col, y: row, width: 15, height: 20))
                }
            }
        }
        return img // return img back to use in main scene
    }
    
    // 20 - Video 4
    func hit(at point: CGPoint) {
        // where in Core Graphics space did the banana hit in our image
    let convertedPoint = CGPoint(x: point.x + size.width / 2, y: abs(point.y - (size.height / 2))) //abs take negative sign and make it positive
    
        let renderer = UIGraphicsImageRenderer(size: size)
        let img = renderer.image { ctx in
            currentImage.draw(at: .zero) // fill current image
            
            // clear circle where hit
            ctx.cgContext.addEllipse(in: CGRect(x: convertedPoint.x - 32, y: convertedPoint.y - 32, width: 64, height: 64)) // centered on hit
            ctx.cgContext.setBlendMode(.clear) // destroy whats there
            ctx.cgContext.drawPath(using: .fill)
        }
        
        // assign it back to SKTexture, assign to currentImage, call configurePhysics again to redraw around new texture
        texture = SKTexture(image: img)
        currentImage = img
        configurePhysics()
    }
}
