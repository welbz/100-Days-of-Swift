//
//  ViewController.swift
//  Project13
//
//  Created by Welby Jennings on 13/7/20.
//  Day 52 https://www.hackingwithswift.com/100/52
//  Day 53 https://www.hackingwithswift.com/100/53
//  Day 54 https://www.hackingwithswift.com/100/54

import CoreImage // call in CoreImage framework
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
// Both are required to be delegate of the UIIamgeViewController
// Need to add to info plist  = Privacy - Photo Library Additions Usage Description
{
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var intensity: UISlider!
    
    // MARK: - Challenge 2 - Show filter name as btn title
    @IBOutlet var filterName: UIButton!
    
    var currentImage: UIImage!
    var context: CIContext! // handles rendering
    var currentFilter: CIFilter! // filter - stores whatever filter usee has activatated
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "YACIFP"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
        // Sepia effect
    }
    
    // MARK: - Challenge 2 - Show filter name as btn title
    func updateUIButtonTitle(btnTitle: String) {
        filterName.setTitle("\(btnTitle)", for: .normal)
        print("finishing func with \(btnTitle)")
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true) // dismiss immediately image picker controller
        
        // MARK: Project 15 - Challenge 2
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 5, options: [], animations: {
              
            // TODO: - continue with this
            self.currentImage = image
            self.currentImage.alpha = 0 // can change alpha and background
            self.currentImage.alpha = 1
        })
        
        // MARK: - Note
        /*
         where we set our currentImage image to be the one selected in the image picker. This is required so that we can have a copy of what was originally imported. Whenever the user changes filter, we need to put that original image back into the filter.
         */
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    // Adding filters to AC
    @IBAction func changeFilter(_ sender: UIButton) { // pin AC to a button on screen
        let ac = UIAlertController(title: "Choose Filter", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popoverController = ac.popoverPresentationController {
            popoverController.sourceView = sender // user sender as source for popover
            popoverController.sourceRect = sender.bounds
        }
        
        present(ac, animated: true)
    }
    
    // Choose filter
    func setFilter(action: UIAlertAction) {
        guard currentImage != nil else { return } // make sure we have an image chosen by user
        guard let actionTitle = action.title else { return } // create new CIFilter
        
        // MARK: - Challenge 2 - Show filter name as btn title
        updateUIButtonTitle(btnTitle: actionTitle)
        
        currentFilter = CIFilter(name: actionTitle)
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
        // Apply processing new filter to selected image
    }
    
    // MARK: - Challenge 1 - Show an Alert if not image is selected
    @IBAction func save(_ sender: Any) {
        guard let image = imageView.image else {
            let ac = UIAlertController(title: "Error!", message: "No image was selected.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            
            present(ac, animated: true)
            
            return
            
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        
    }
    
    
    @IBAction func intensityChange(_ sender: Any) {
        applyProcessing()
    }
    
    
    func applyProcessing() {
        
        let inputKeys = currentFilter.inputKeys // read all inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey) // 200 time stronger than normal
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey) // 10 time stronger than normal
        }
        
        if inputKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)
        } // divide 2 centers effect on image
        
        guard let outputImage = currentFilter.outputImage else { return }
        // used below in case we cant get the image
        
        /*
         Not all filters have kCIInputIntensityKey so we cannot use below
         currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey) // reads slider value and uses as intensity
         Cant covert CIIMage into a UIImage easily - need CGImage
         Core Image > Core Grpahics > UIImage
         */
        
        // create a cgIMage from our coreImage filter
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) { // extent means read the whole image
            let processedImage = UIImage(cgImage: cgImage)
            imageView.image = processedImage // If we can read a CGImage, we convert it to be a UIImage and put into the image view
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            
            present(ac, animated: true)
        }
    }
    
}

