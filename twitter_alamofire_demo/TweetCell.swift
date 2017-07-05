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


//protocol TweetCellDelegate {
//    func didTapReply()
//}

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    //add retweet, like buttons
    
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            timestampLabel.text = tweet.createdAtString
            screenNameLabel.text = tweet.user.name
            twitterHandleLabel.text = "@" + tweet.user.screenName!
            
            if tweet.favorited {
                likeButton.isSelected = true
            }
            
            if tweet.retweeted {
                retweetButton.isSelected = true
            }
            
            //to show the current
            favoriteCountLabel.text = String(tweet.favoriteCount)
            if tweet.favorited {
                retweetCountLabel.text = String(tweet.retweetCount)
            }
            
            
            let validURL = URL(string: tweet.user.profPicURLString!)
            if validURL != nil{
                userProfilePic.af_setImage(withURL: validURL!)
            }
            }
        }
    
    @IBAction func onRetweetButton(_ sender: Any) {
        
        var currentRetweetCount = tweet.retweetCount
        
        if retweetButton.isSelected == false {
            retweetButton.isSelected = true
            currentRetweetCount += 1
            retweetCountLabel.text = String(currentRetweetCount)
            
        } else {
            retweetButton.isSelected = false
            currentRetweetCount -= 1
            retweetCountLabel.text = String(currentRetweetCount)
        }
        
    }

    
    @IBAction func onFavoriteButton(_ sender: Any) {
        //Update the local tweet model
        //Update cell UI
        //Send a POST request to the POST favorites/create endpoint
        
        //var currentFavoriteCount = self.tweet.favoriteCount
        
        if likeButton.isSelected == false {
            tweet.favorited = true
            tweet.favoriteCount += 1
            likeButton.isSelected = true

            favoriteCountLabel.text = String(describing: tweet.favoriteCount)
            
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        
        } else { //like button is selected
            likeButton.isSelected = false
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
