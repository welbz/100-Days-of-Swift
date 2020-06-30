//
//  Notes.swift
//  Project10
//
//  Created by Welby Jennings on 19/6/20.
//  Copyright © 2020 Zake Media Pty Ltd. All rights reserved.
//

import Foundation

/*
 That tells Swift you promise your class supports all the functionality required by the two protocols UIImagePickerControllerDelegate and UINavigationControllerDelegate. The first of those protocols is useful, telling us when the user either selected a picture or cancelled the picker. The second, UINavigationControllerDelegate, really is quite pointless here, so don't worry about it beyond just modifying your class declaration to include the protocol.
 When you conform to the UIImagePickerControllerDelegate protocol, you don't need to add any methods because both are optional. But they aren't really – they are marked optional for whatever reason, but your code isn't much good unless you implement at least one of them!
 The delegate method we care about is imagePickerController(_, didFinishPickingMediaWithInfo:), which returns when the user selected an image and it's being returned to you. This method needs to do several things:
     •    Extract the image from the dictionary that is passed as a parameter.
     •    Generate a unique filename for it.
     •    Convert it to a JPEG, then write that JPEG to disk.
     •    Dismiss the view controller.
 To make all this work you're going to need to learn a few new things.
 First, it's very common for Apple to send you a dictionary of several pieces of information as a method parameter. This can be hard to work with sometimes because you need to know the names of the keys in the dictionary in order to be able to pick out the values, but you'll get the hang of it over time.
 This dictionary parameter will contain one of two keys: .editedImage (the image that was edited) or .originalImage, but in our case it should only ever be the former unless you change the allowsEditing property.
 The problem is, we don't know if this value exists as a UIImage, so we can't just extract it. Instead, we need to use an optional method of typecasting, as?, along with if let. Using this method, we can be sure we always get the right thing out.
 Second, we need to generate a unique filename for every image we import. This is so that we can copy it to our app's space on the disk without overwriting anything, and if the user ever deletes the picture from their photo library we still have our copy. We're going to use a new type for this, called UUID, which generates a Universally Unique Identifier and is perfect for a random filename.
 Third, once we have the image, we need to write it to disk. You're going to need to learn two new pieces of code: UIImage has a jpegData() to convert it to a Data object in JPEG image format, and there's a method on Data called write(to:) that, well, writes its data to disk. We used Data earlier, but as a reminder it’s a relatively simple data type that can hold any type of binary type – image data, zip file data, movie data, and so on.
 Writing information to disk is easy enough, but finding where to put it is tricky. All apps that are installed have a directory called Documents where you can save private information for the app, and it's also automatically synchronized with iCloud. The problem is, it's not obvious how to find that directory, so I have a method I use called getDocumentsDirectory() that does exactly that – you don't need to understand how it works, but you do need to copy it into your code.

 */
