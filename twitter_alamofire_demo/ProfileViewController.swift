//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Isabella Teng on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet] = []
    
    var profileUser: User = User.current!

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        APIManager.shared.saveUserScreenName(userScreenName: profileUser.screenName!)
        
        getTweets()
        
        profileImageView.layer.cornerRadius = 25
        profileImageView.clipsToBounds = true
        
        let validURL = profileUser.profPicURL
        if validURL != nil {
            profileImageView.af_setImage(withURL: validURL!)
        }
        
        let validBackgroundURL = profileUser.backgroundURL
        if validBackgroundURL != nil {
            backgroundImageView.af_setImage(withURL: validBackgroundURL!)
        }
        
        fullNameLabel.text = profileUser.name
        usernameLabel.text = profileUser.screenName
        followersCountLabel.text = String(describing: profileUser.followersCount)
        followingCountLabel.text = String(describing: profileUser.followingCount)
    }
    
    func getTweets() {
        APIManager.shared.getUserTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting user timeline: " + error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTweetsCell", for: indexPath) as! ProfileTweetsCell
        
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
