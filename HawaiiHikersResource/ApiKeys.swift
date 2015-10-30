//
//  ApiKeys.swift
//  HawaiiHkersResource
//
//  Created by Kenneth Nagata on 9/23/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//
import Foundation


// function will retireve the requested api key and client id from property list
// kn
func valueForAPIKey(keyname keyname:String) -> String {
    let filePath = NSBundle.mainBundle().pathForResource("ApiKeys", ofType:"plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    
    let value:String = plist?.objectForKey(keyname) as! String
    return value
}