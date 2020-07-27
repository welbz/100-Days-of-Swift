//
//  ViewController.swift
//  Milestone Project 4
//
//  Created by Welby Jennings on 19/6/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

// Milestone Project 4 (From Project 12b)
// www.hackingwithswift.com/100/50
// www.hackingwithswift.com/guide/5/3/challenge


import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var people = [Person]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
        // load array back from disk when app runs
        let defaults = UserDefaults.standard
        if let savedPeople = defaults.object(forKey: "people") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                people = try jsonDecoder.decode([Person].self, from: savedPeople)
            } catch {
                print("Failed to load people")
            }
        }
        /*
         This code is effectively the save() method in reverse: we use the object(forKey:) method to pull out an optional Data, using if let and as? to unwrap it. We then give that to an instance of JSONDecoder to convert it back to an object graph – i.e., our array of Person objects.

         Once again, note the interesting syntax for decode() method: its first parameter is [Person].self, which is Swift’s way of saying “attempt to create an array of Person objects.” This is why we don’t need a typecast when assigning to people – that method will automatically return [People], or if the conversion fails then the catch block will be executed instead.
         */
        
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return people.count
//    }
    
    
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
        
//        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
//        cell.imageView.layer.borderWidth = 2
//        cell.imageView.layer.cornerRadius = 3
//        cell.layer.cornerRadius = 7
        
        // if we're still here it means we got a PersonCell, so we can return it
        return cell
    }
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true // allows editing
        picker.delegate = self // assign ourself as delegate
        present(picker, animated: true) // display
    }
    

    // Add picker.sourceType = .camera
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
        // save after append
        save()
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
    
    // Push to detail
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            person.name = newName
            // save data as soon as rename a person
            self?.save()
            self?.collectionView.reloadData()
        })
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func save() {
        let jsonEndcoder = JSONEncoder()
        
        if let savedData = try? jsonEndcoder.encode(people) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "people")
        } else {
            print("Failed to save people")
        }
    }
}

