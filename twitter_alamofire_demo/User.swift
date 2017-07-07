//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    //properties of user
    var name: String
    var screenName: String?
    var profPicURL: URL?
    var backgroundURL: URL?
    var followersCount: Int //Display followers count of current user
    var followingCount: Int //Display following count of current user
    //var userID: String?
    
    // For user persistance
    var dictionary: [String: Any]?
    private static var _current: User?
    
    
    init(dictionary: [String: Any]) {
        // Initialize properties
        self.dictionary = dictionary
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as? String
        profPicURL = URL(string: dictionary["profile_image_url_https"] as! String)
        backgroundURL = URL(string: dictionary["profile_background_image_url_https"] as! String)
        
        followersCount = dictionary["followers_count"] as! Int
        followingCount = dictionary["friends_count"] as! Int
        
    }
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
}
