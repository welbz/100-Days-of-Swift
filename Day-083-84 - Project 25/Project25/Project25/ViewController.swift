//
//  ViewController.swift
//  Project25
//  https://www.hackingwithswift.com/100/83
    // https://www.hackingwithswift.com/read/25/1/setting-up
    // https://www.hackingwithswift.com/read/25/2/importing-photos-again
    // https://www.hackingwithswift.com/read/25/3/going-peer-to-peer-mcsession-mcbrowserviewcontroller
    // https://www.hackingwithswift.com/read/25/4/invitation-only-mcpeerid
//
//  Created by Welby Jennings on 20/9/20.
//

import MultipeerConnectivity
import UIKit

class ViewController: UICollectionViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MCSessionDelegate, MCBrowserViewControllerDelegate {
    var images = [UIImage]()

    // 7 - https://www.hackingwithswift.com/read/25/3/going-peer-to-peer-mcsession-mcbrowserviewcontroller
    // var peerID: MCPeerID? - use below instead
    var peerID = MCPeerID(displayName: UIDevice.current.name) // get name of current device user is on
    var mcSession: MCSession?
    var mcAdvertiserAssistant: MCAdvertiserAssistant?
    // See Notes
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // 1 - https://www.hackingwithswift.com/read/25/2/importing-photos-again
        title = "Selfie Share"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture))
        
    // 5 - https://www.hackingwithswift.com/read/25/3/going-peer-to-peer-mcsession-mcbrowserviewcontroller
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))
        
    // 8 - https://www.hackingwithswift.com/read/25/3/going-peer-to-peer-mcsession-mcbrowserviewcontroller
        // set peerID above instead of here so we dont need to force unwrap
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession?.delegate.self
    }
    
    //9 - https://www.hackingwithswift.com/read/25/3/going-peer-to-peer-mcsession-mcbrowserviewcontroller
    func startHosting(action: UIAlertAction) {
        guard let mcSession = mcSession else { return } // make sure it exists
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "zake-project25", discoveryInfo: nil, session: mcSession)
    }
    
    func joinSession(action: UIAlertAction) {
        guard let mcSession = mcSession else { return } // make sure it exists
        let mcBrowser = MCBrowserViewController(serviceType: "zake-project25", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    
    
    // 2 - https://www.hackingwithswift.com/read/25/2/importing-photos-again
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    // 3 - See notes on Tags and cellForItemAt below - https://www.hackingwithswift.com/read/25/2/importing-photos-again
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageView", for: indexPath)
        
        if let imageView = cell.viewWithTag(1000) as? UIImageView {
            imageView.image = images[indexPath.item]
        }
        
        return cell
    }

    // 4 - Image Picker - https://www.hackingwithswift.com/read/25/2/importing-photos-again
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        
        images.insert(image, at: 0)
        collectionView.reloadData()
    } // read out image or bail out, dismiss viewController, insert into images array, then show it collectionView stright away

    
    // 6 - See notes on Multipeer connectivity - https://www.hackingwithswift.com/read/25/3/going-peer-to-peer-mcsession-mcbrowserviewcontroller
    @objc func showConnectionPrompt() {
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    
    
}
