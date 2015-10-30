//
//  PushNotificationController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 10/29/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//

import Foundation

// Encapsulate parse.com push notifications
class PushNotificationController : NSObject {
    
    override init() {
        super.init()
        
        // Retrieve Apikeys from file
        let parseApplicationId = valueForAPIKey(keyname: "PARSE_APPLICATION_ID")
        let parseClientKey     = valueForAPIKey(keyname: "PARSE_CLIENT_KEY")
        // Sets the Id and Key for parse
        Parse.setApplicationId(parseApplicationId, clientKey: parseClientKey)
        
    }
}