//
//  Notes.swift
//  Project15
//
//  Created by Welby Jennings on 29/7/20.
//

import Foundation

/* Rotation
 We can also use CGAffineTransform to rotate views, using its rotationAngle initializer. This accepts one parameter, which is the amount in radians you want to rotate. There are three catches to using this function:

 You need to provide the value in radians specified as a CGFloat. This usually isn't a problem – if you type 1.0 in there, Swift is smart enough to make that a CGFloat automatically. If you want to use a value like pi, use CGFloat.pi.
 Core Animation will always take the shortest route to make the rotation work. So, if your object is straight and you rotate to 90 degrees (radians: half of pi), it will rotate clockwise. If your object is straight and you rotate to 270 degrees (radians: pi + half of pi) it will rotate counter-clockwise because it's the smallest possible animation.
 A consequence of the second catch is that if you try to rotate 360 degrees (radians: pi times 2), Core Animation will calculate the shortest rotation to be "just don't move, because we're already there." The same goes for values over 360, for example if you try to rotate 540 degrees (one and a half full rotations), you'll end up with just a 180-degree rotation.
 */
