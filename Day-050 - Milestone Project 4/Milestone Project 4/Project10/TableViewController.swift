//
//  TableViewController.swift
//  Project10
//
//  Created by Welby Jennings on 26/7/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    // dequeueReusableCell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath) as? PictureCell
        else {
            fatalError("Unable to dequeue a PersonCell")
        }
        
        let person = people[indexPath.item]
        cell.textLabel?.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.pictureImageView.image = UIImage(contentsOfFile: path.path)
    
        cell.pictureImageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.pictureImageView.layer.borderWidth = 2
        cell.pictureImageView.layer.cornerRadius = 4
        
        // if we're still here it means we got a PersonCell, so we can return it
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let person = people[indexPath.item]
            
            vc.selectedImage = person.image
            vc.imageCaption = person.name
            
            navigationController?.pushViewController(vc, animated: true)
        }
}
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true // allows editing
        picker.delegate = self // assign ourself as delegate
        
        // This is only available on devices - Need to add access to info plist first
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true) // display
    }
    

    // Add picker.sourceType = .camera
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        // converts image to jpeg data
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Default Name", image: imageName)
        
        let ac = UIAlertController(title: "Name Your Image", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Rename", style: .default) {
            [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            
            if newName.isEmpty || newName == " " {
                return
            } else {
            person.name = newName
            
            self?.tableView.reloadData()
            }
        })
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
        
        people.append(person)
        // save after append
        save()
        tableView.reloadData()
        /*
         That stores the image name in the Person object and gives them a default name of "Default Name", before reloading the tableView
         */
        
        dismiss(animated: true) // dismiss the top most viewController (imagePicker)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) // asks for documentDirectory and we want that for our current user
        return paths[0] // returns first item in documentDirectory
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
