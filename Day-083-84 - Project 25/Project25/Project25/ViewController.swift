//
//  ViewController.swift
//  Project25
//  https://www.hackingwithswift.com/100/83
// Video 1 https://www.hackingwithswift.com/read/25/1/setting-up
// Video 2 https://www.hackingwithswift.com/read/25/2/importing-photos-again
// Video 3 https://www.hackingwithswift.com/read/25/3/going-peer-to-peer-mcsession-mcbrowserviewcontroller
// Video 4 https://www.hackingwithswift.com/read/25/4/invitation-only-mcpeerid
//
//  Created by Welby Jennings on 20/9/20.
//


//FIXME:- Not working in iOS13 onwards
// https://stackoverflow.com/questions/58563621/multipeer-connectivity-not-working-after-xcode-11-update
// https://stackoverflow.com/questions/57467003/opt-out-of-uiscenedelegate-swiftui-on-ios

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
        
        // 1 - Video 2
        title = "Selfie Share"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture))
        
        // 5 -  Video 3
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))
        
        // 8 -  Video 3
        // set peerID above instead of here so we dont need to force unwrap
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession?.delegate = self
    }
    
    // 9a -  Video 3
    func startHosting(action: UIAlertAction) {
        guard let mcSession = mcSession else { return } // make sure it exists
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "zake-project25", discoveryInfo: nil, session: mcSession)
        
        //12 - Start looking for collections - Video 4
        mcAdvertiserAssistant?.start()
    }
    
    // 9b -  Video 3
    func joinSession(action: UIAlertAction) {
        guard let mcSession = mcSession else { return } // make sure it exists
        let mcBrowser = MCBrowserViewController(serviceType: "zake-project25", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    
    
    // 2 - Video 2
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    // 3 - See notes on Tags and cellForItemAt below - Video 2
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageView", for: indexPath)
        
        if let imageView = cell.viewWithTag(1000) as? UIImageView {
            imageView.image = images[indexPath.item]
        }
        
        return cell
    }
    
    // 4 - Image Picker - Video 2
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
        // read out image or bail out, dismiss viewController, insert into images array, then show it collectionView stright away
        
        
        // 11 - See Notes
        // 1)
        guard let mcSession = mcSession else { return } // check we have a session or bail out
        
        // 2)
        if mcSession.connectedPeers.count > 0 {
            // 3)
            if let imageData =  image.pngData() { // convert image to png data
                // 4) - try and send our data to all peers
                do {
                    try mcSession.send(imageData, toPeers: mcSession.connectedPeers, with: .reliable) // reliable or unreliable are options
                } catch {
                    // 5) if fails
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    present(ac, animated: true)
                }
            }
        }
    }
    
    
    
    
    
    // 6 - See notes on Multipeer connectivity - Video 3
    @objc func showConnectionPrompt() {
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    
    //10 - Video 4 - https://www.hackingwithswift.com/read/25/4/invitation-only-mcpeerid
    // See notes
    // 7 menthods that are required for the delegates we added
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // not needed for this projects
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        // not needed for this projects
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        // not needed for this projects
    }
    
    // methods that are required that we will use
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    // diagnostic method - helpful for debugging
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("Connected: \(peerID.displayName)")

        case .connecting:
            print("Connecting: \(peerID.displayName)")

        case .notConnected:
            print("Not Connected: \(peerID.displayName)")

        @unknown default:
            print("Unknown state received: \(peerID.displayName)")
        }
    }
    
    // Protocol Method to recevie data
    // When the image is added it also gets sent to peers
    // image is convereted to data, data is sent to peer, peer receives data, peer converts data back to image
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async { [weak self ] in // push to main thread and safely manipluate UI
            if let image = UIImage(data: data) { // make UIImage from out data
                self?.images.insert(image, at: 0) // if successful insert into our images array
                self?.collectionView.reloadData() //reload collectionView data
            }
        } // Always have to be on main thread to do this UI work
    }
    
}
