//
//  ViewController.swift
//  Project10
//
//  Created by Welby Jennings on 19/6/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

//  Project 10
// www.hackingwithswift.com/100/42
// www.hackingwithswift.com/100/43
// www.hackingwithswift.com/100/44


import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // UIImagePickerControllerDelegate - tells us when user chooses images or closes picker
    // UINavigationControllerDelegate
    /*
     The delegate method we care about is imagePickerController(_, didFinishPickingMediaWithInfo:), which returns when the user selected an image and it's being returned to you. This method needs to do several things:
     Extract the image from the dictionary that is passed as a parameter.
     Generate a unique filename for it.
     Convert it to a JPEG, then write that JPEG to disk.
     Dismiss the view controller.
     */
    
    var people = [Person]()
    /*
     Every time we add a new person, we need to create a new Person object with their details. This is as easy as modifying our initial image picker success method so that it creates a Person object, adds it to our people array, then reloads the collection view
     */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }
    
    // number of sections in UICollectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    // cell in UICollectionView
    // dequeueReusableCell recycles the cell scrolls out of view
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue a PersonCell")
        }
        
        let person = people[indexPath.item]
        
        cell.name.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        
        
        // if we're still here it means we got a PersonCell, so we can return it
        return cell
    }
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true // allows editing
        picker.delegate = self // assign ourself as delegate
        present(picker, animated: true) // display
    }
    
    
    // Challenge 2
    //Try using picker.sourceType = .camera which will tell it to create a new image by taking a photo.
    //This is only available on devices
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        // converts image to jpeg data
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        /*
         That stores the image name in the Person object and gives them a default name of "Unknown", before reloading the collection view
         */
        
        dismiss(animated: true) // dismiss the top most viewController (imagePicker)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) // asks for documentDirectory and we want that for our current user
        return paths[0] // returns first item in documentDirectory
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            person.name = newName
            self?.collectionView.reloadData()
        })
            
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
}

