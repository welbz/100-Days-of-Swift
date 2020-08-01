//
//  Notes.swift
//  Project16
//
//  Created by Welby Jennings on 1/8/20.
//

import Foundation

// NOTES

/*
 Need to drag from map to VC and set to "delegate"
 
 import MapKit - must add so Swift knows what MKMapView is
 
 
 
 Annotiation info
 
 Every time the map needs to show an annotation, it calls a viewFor method on its delegate.
 
 We don't implement that method right now, so the default red pin is used with nothing special – although as you've seen it's smart enough to pull out the title for us.
 
 Customizing an annotation view is a little bit like customizing a table view cell or collection view cell, because iOS automatically reuses annotation views to make best use of memory. If there isn't one available to reuse, we need to create one from scratch using the MKPinAnnotationView class.

 Our custom annotation view is going to look a lot like the default view, with the exception that we're going to add a button that users can tap for more information. So, they tap the pin to see the city name, then tap its button to see more information. In our case, it's those fascinating facts I spent literally tens of seconds writing.

 
 
 There are a couple of things you need to be careful of here.
 
 First, viewFor will be called for your annotations, but also Apple's. For example, if you enable tracking of the user's location then that's shown as an annotation and you don't want to try using it as a capital city.
 If an annotation is not one of yours, just return nil from the method to have Apple's default used instead.

 Second, adding a button to the view isn't done using the addTarget() method you already saw in project 8.
 Instead, you just add the button and the map view will send a message to its delegate (us!) when it's tapped.

 Here's a breakdown of what the method will do:

 If the annotation isn't from a capital city, it must return nil so iOS uses a default view.
 Define a reuse identifier. This is a string that will be used to ensure we reuse annotation views as much as possible.
 
 Try to dequeue an annotation view from the map view's pool of unused views.
    If it isn't able to find a reusable view, create a new one using MKPinAnnotationView and sets its canShowCallout property to true. This triggers the popup with the city name.
 
 Create a new UIButton using the built-in .detailDisclosure type. This is a small blue "i" symbol with a circle around it.
 If it can reuse a view, update that view to use a different annotation.
 
 We already used Interface Builder to make our view controller the delegate for the map view, but if you want code completion to work you should also update your code to declare that the class conforms
 */

