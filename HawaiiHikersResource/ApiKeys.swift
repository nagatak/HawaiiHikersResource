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
func valueForAPIKey(keyname:String) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType:"plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    
    let value:String = plist?.object(forKey: keyname) as! String
    return value
}
