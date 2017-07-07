//
//  ProfileTweetsCell.swift
//  twitter_alamofire_demo
//
//  Created by Isabella Teng on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import Alamofire
import AlamofireImage

class ProfileTweetsCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var tweetTextView: UILabel!
    
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetTextView.text = tweet.text
            timeStampLabel.text = tweet.createdAtString
            screenNameLabel.text = tweet.user.name
            usernameLabel.text = "@" + tweet.user.screenName!
            
            if tweet.favorited {
                favoriteButton.isSelected = true
            }
            
            if tweet.retweeted {
                retweetButton.isSelected = true
            }
            
            //to show the current
            favoriteCountLabel.text = String(tweet.favoriteCount)
            retweetCountLabel.text = String(tweet.retweetCount)
            
            profileImageView.layer.cornerRadius = 15
            profileImageView.clipsToBounds = true
            let validURL = tweet.user.profPicURL
            if validURL != nil{
                //print(hi)
                profileImageView.af_setImage(withURL: validURL!)
            }
        }
    }
    
    
    @IBAction func onRetweetButton(_ sender: Any) {
        if retweetButton.isSelected == false {
            retweetButton.isSelected = true
            tweet.retweeted = true
            tweet.retweetCount += 1
            
            retweetCountLabel.text = String(describing: tweet.retweetCount)
            
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
            
        } else {
            retweetButton.isSelected = false
            tweet.retweeted = false
            tweet.retweetCount -= 1
            
            retweetCountLabel.text = String(describing: tweet.retweetCount)
            
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }

    }
    

    @IBAction func onFavoriteButton(_ sender: Any) {
        if favoriteButton.isSelected == false {
            tweet.favorited = true
            tweet.favoriteCount += 1
            favoriteButton.isSelected = true
            
            favoriteCountLabel.text = String(describing: tweet.favoriteCount)
            
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        } else { //like button is selected
            favoriteButton.isSelected = false
            tweet.favoriteCount -= 1
            tweet.favorited = false
            
            favoriteCountLabel.text = String(describing: tweet.favoriteCount)
            
            APIManager.shared.unfavorite(tweet, completion: { (tweet: Tweet?, error:Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
                
            })
            
        }

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
