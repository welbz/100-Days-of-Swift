//
//  ViewController.swift
//  Project13
//
//  Created by Welby Jennings on 13/7/20.
//  Day 52 https://www.hackingwithswift.com/100/52
//  Day 53 https://www.hackingwithswift.com/100/53
//  Day 54 https://www.hackingwithswift.com/100/54


import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
    // Both are required to be delegate of the UIIamgeViewController
    // Need to add to info plist  = Privacy - Photo Library Additions Usage Description
{
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var intensity: UISlider!
    
    var currentImage: UIImage!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "YACIFP"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        
    }

    @IBAction func changeFilter(_ sender: Any) {
    }
    
    
    @IBAction func save(_ sender: Any) {
    }
    
    
    @IBAction func intensityChange(_ sender: Any) {
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
        
        currentImage = image
        
        // MARK: - Note
        /*
         where we set our currentImage image to be the one selected in the image picker. This is required so that we can have a copy of what was originally imported. Whenever the user changes filter, we need to put that original image back into the filter.
         */
    }
    
}

