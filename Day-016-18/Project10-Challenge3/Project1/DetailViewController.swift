//
//  DetailViewController.swift
//  Project1
//
//  Created by Welby Jennings on 24/5/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    /*
     Creates outlets as implicitly unwrapped optionals
     This is required because the view won't exist when the view controller is first created, but it will exist shortly afterwards and then continue to exist for the life of the view controller
     
     When the basic stuff has been done (allocating enough memory to hold it all, for example), iOS goes ahead and loads the layout from the storyboard, then connects all the outlets from the storyboard to the code.

    So, when the detail controller is first made, the UIImageView doesn't exist because it hasn't been created yet – but we still need to have some space for it in memory. At this point, the property is nil, or just some empty memory. But when the view gets loaded and the outlet gets connected, the UIImageView will point to a real UIImageView, not to nil, so we can start using it.
     
     In short: it starts life as nil, then gets set to a value before we use it, so we're certain it won't ever be nil by the time we want to use it – a textbook case of implicitly unwrapped optionals
     */
    
    var selectedImage: String? // optional since it wont exist when view is created
    var pictureTotal = 0
    var pictureIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Picture \(pictureIndex + 1) of \(pictureTotal)"
        navigationItem.largeTitleDisplayMode = .never  // forces normal size title

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad) // if no image wont run
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
