//
//  Notes.swift
//  Milestone Project 3
//
//  Created by Welby Jennings on 18/7/20.
//  Milestone Project 3
//  Recap Projects 7-9 (Days 33-40)
//  https://www.hackingwithswift.com/100/41

import Foundation

/*
 NOTES

 Swift has a special data type for individual letters, called Character. It’s easy to create strings from characters and vice versa, but you do need to know how it’s done.

 First, the individual letters of a string are accessible simply by treating the string like an array – it’s a bit like an array of Character objects that you can loop over, or read its count property, just like regular arrays.

 When you write for letter in word, the letter constant will be of type Character, so if your usedLetters array contains strings you will need to convert that letter into a string, like this:

 let strLetter = String(letter)
 
 Note: unlike regular arrays, you can’t read letters in strings just by using their integer positions – they store each letter in a complicated way that prohibits this behavior.

 Once you have the string form of each letter, you can use contains() to check whether it’s inside your usedLetters array.
 
*/
