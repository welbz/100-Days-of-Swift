//
//  ViewController.swift
//  Project27
//
//  Created by Welby Jennings on 27/9/20.
//
// https://www.hackingwithswift.com/100/88
    // Video 2 - https://www.hackingwithswift.com/read/27/2/creating-the-sandbox
    // Video 3 - https://www.hackingwithswift.com/read/27/3/drawing-into-a-core-graphics-context-with-uigraphicsimagerendere
    // Video 4 - https://www.hackingwithswift.com/read/27/4/ellipses-and-checkerboards
    // Video 5 - https://www.hackingwithswift.com/read/27/5/transforms-and-lines
    // Video 6 - https://www.hackingwithswift.com/read/27/6/images-and-text

import UIKit

class ViewController: UIViewController {
    
    // 1 - Video 2
    @IBOutlet var imageView: UIImageView!
    var currentDrawType = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        drawRectangle()
    }

    // 1 - Video 2
    @IBAction func RedrawTapped(_ sender: Any) {
        currentDrawType += 1
        print(currentDrawType)
        
        if currentDrawType > 5 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        
        case 1:
            drawCircle() // 5 - Video 4
        
        case 2:
            drawCheckerBoard() // 7 - Video 4
        
        case 3:
            drawRotatedSquares() // 8 - Video 5
        
        default:
            break
        }
    }
    
    // 2 - Video 2
    func drawRectangle() {
        // 3 - Video 3 creates canvas to draw on (context) / canvas and meta data
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512)) // in pt not px
        
        // 4 - Video 3
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle) // add rect to path
            ctx.cgContext.drawPath(using: .fillStroke) // this actually draws it
        }
        
        imageView.image = img
    }
    
    // 6 - Video 4
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512)) // in pt not px
        
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle) // add rect to path
            ctx.cgContext.drawPath(using: .fillStroke) // this actually draws it
        }
        
        imageView.image = img
    }

    // 7 - Video 4
    func drawCheckerBoard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512)) // in pt not px
        
        
        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col) % 2 == 0 { // offsets it for the checkers
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = img
    }
    
    // 8 - Video 5
    func drawRotatedSquares() {
        // Rotates by top left corner
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512)) // in pt not px
        
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0..<rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor) // sets stroke
            ctx.cgContext.strokePath() // draws stroke
        }
        
        imageView.image = img
    }
    
}

