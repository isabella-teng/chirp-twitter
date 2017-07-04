//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    //add retweet, like buttons
    var retweeted: Bool = false
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            timestampLabel.text = tweet.createdAtString
            screenNameLabel.text = tweet.user.name
            twitterHandleLabel.text = "@" + tweet.user.screenName!

            let validURL = URL(string: tweet.user.profPicURLString!)
            if validURL != nil{
                userProfilePic.af_setImage(withURL: validURL!)
            }
            
        }
    }
    
    @IBAction func onRetweetButton(_ sender: Any) {
        if retweeted == false {
            retweetButton.isSelected = true
            retweeted = true
        } else {
            retweetButton.isSelected = false
            retweeted = false
        }
        
    }
    
    @IBAction func onFavoriteButton(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
