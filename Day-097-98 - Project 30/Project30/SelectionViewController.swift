//
//  SelectionViewController.swift
//  Project30
//
//  Created by TwoStraws on 20/08/2016.
//  Copyright (c) 2016 TwoStraws. All rights reserved.
//

// Notes
    // Command I to open instruments
    // can searc to filter eg UI
    // malloc = memory allocate
    // peristance = created and still exist
    // transient = created and destroyed



import UIKit

class SelectionViewController: UITableViewController {
	var items = [String]() // this is the array that will store the filenames to load

    // 8 - Video 6 - removed now its not used
    //	var viewControllers = [UIViewController]() // create a cache of the detail view controllers for faster loading
	var dirty = false

    override func viewDidLoad() {
        super.viewDidLoad()

		title = "Reactionist"

		tableView.rowHeight = 90
		tableView.separatorStyle = .none
        
        // 5 - Video 5 - When we request a cell we immediatly get one back reused automatically and never nil
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

		// load all the JPEGs into our array
		let fm = FileManager.default

		if let tempItems = try? fm.contentsOfDirectory(atPath: Bundle.main.resourcePath!) {
			for item in tempItems {
				if item.range(of: "Large") != nil {
					items.append(item)
				}
			}
		}
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		if dirty {
			// we've been marked as needing a counter reload, so reload the whole table
			tableView.reloadData()
		}
	}

    // MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return items.count * 10
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 6 - Video 5
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        // 4 - Video 4 - ReusableCell
//        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
//
//        // if it fails make a new cell
//        if cell == nil {
//            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
//        }
        
        
		// find the image for this cell, and load its thumbnail
		let currentImage = items[indexPath.row % items.count]
		let imageRootName = currentImage.replacingOccurrences(of: "Large", with: "Thumb")
		let path = Bundle.main.path(forResource: imageRootName, ofType: nil)!
		let original = UIImage(contentsOfFile: path)!

        // 2 - Video 3 - create image render to correct size
        let renderRect = CGRect(origin: .zero, size: CGSize(width:90, height: 90))
        
        let renderer = UIGraphicsImageRenderer(size: renderRect.size) // use new size
		// let renderer = UIGraphicsImageRenderer(size: original.size) // ws using full original size 2500px

		let rounded = renderer.image { ctx in
//            // 1 - Video 3 - fixing shadows with setShadow
//            // draws shadow inside UIImage rendere path
//            ctx.cgContext.setShadow(offset: .zero, blur: 200, color: UIColor.black.cgColor) // 200 blur relative to size of image been drawn original.size
//            ctx.cgContext.fillEllipse(in: CGRect(origin: .zero, size: original.size)) // draw elips full size of our image using our shadow
//            ctx.cgContext.setShadow(offset: .zero, blur: .zero, color: nil) // nil colour clears shadow
            
            // original code
            ctx.cgContext.addEllipse(in: renderRect)
            // ctx.cgContext.addEllipse(in: CGRect(origin: CGPoint.zero, size: original.size))
			ctx.cgContext.clip()

            original.draw(in: renderRect) // load large image but scaled down
			//original.draw(at: CGPoint.zero)
		}

		cell.imageView?.image = rounded

        // original shadows
		// give the images a nice shadow to make them look a bit more dramatic
		cell.imageView?.layer.shadowColor = UIColor.black.cgColor
		cell.imageView?.layer.shadowOpacity = 1
		cell.imageView?.layer.shadowRadius = 10
		cell.imageView?.layer.shadowOffset = CGSize.zero
        
        // 3 - Video 4 - set shadow path
        // This way UI doesnt need to find the shadow cause we set it doesnt need a second render pass
        cell.imageView?.layer.shadowPath = UIBezierPath(ovalIn: renderRect).cgPath

		// each image stores how often it's been tapped
		let defaults = UserDefaults.standard
		cell.textLabel?.text = "\(defaults.integer(forKey: currentImage))"

		return cell
    }
    
    
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = ImageViewController()
		vc.image = items[indexPath.row % items.count]
		vc.owner = self

		// mark us as not needing a counter reload when we return
		dirty = false

// 7 - remove no need to cache
    //		add to our view controller cache and show
    //		viewControllers.append(vc)
		navigationController!.pushViewController(vc, animated: true)
	}
}
