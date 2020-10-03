//
//  GameViewController.swift
//  Project29
//
//  Created by Welby Jennings on 2/10/20.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    // 6 - Video 3
    var currentGame: GameScene? // direct access to GameScene
    
    
    // 8 - Video 3
    @IBOutlet var angleSlider: UISlider!
    @IBOutlet var angleLabel: UILabel!
    
    @IBOutlet var velocitySlider: UISlider!
    @IBOutlet var velocityLabel: UILabel!
    
    @IBOutlet var playerNumber: UILabel!
    @IBOutlet var launchButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // creates and shows GameScene
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                // 7 - Video 3
                currentGame = scene as? GameScene // be safe
                currentGame?.viewConroller = self
                // set VC to be self - establish communication between them
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        // 9 - Video 3
        angleChanged(self)
        velocityChanged(self)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // 8 - Video 3
    @IBAction func angleChanged(_ sender: Any) {
        // left slider
        angleLabel.text = "Angle: \(Int(angleSlider.value))°" // convert to Int
    }
    
    @IBAction func velocityChanged(_ sender: Any) {
        // right slider
        velocityLabel.text = "Velocity: \(Int(velocitySlider.value))"
    }
    
    @IBAction func launch(_ sender: Any) {
        // 10 - Video 3
        angleSlider.isHidden = true
        angleLabel.isHidden = true
        
        velocitySlider.isHidden = true
        velocityLabel.isHidden = true
        
        launchButton.isHidden = true
        
        currentGame?.launch(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
    }
    /*
     When a player taps the launch button, we need to hide the user interface so they can't try to fire again until we're ready, then tell the game scene to launch a banana using the current angle and velocity. Our game will then proceed with physics calculations until the banana is destroyed or lost (i.e., off screen), at which point the game will tell the game controller to change players and continue.
     
     The code for the launch() method - the work of actually launching the banana is hidden behind a call to a launch() method that we'll add to the game scene shortly
     */
    
    // 11 - Video 3
    func activatePlayer(number: Int) {
        if number == 1 {
            playerNumber.text = "<<< PLAYER ONE"
        } else {
            playerNumber.text = "PLAYER TWO >>>"
        }
        
        angleSlider.isHidden = false
        angleLabel.isHidden = false
        
        velocitySlider.isHidden = false
        velocityLabel.isHidden = false
        
        launchButton.isHidden = false
    }
    
}
