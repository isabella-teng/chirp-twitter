//
//  ReplyViewController.swift
//  twitter_alamofire_demo
//
//  Created by Isabella Teng on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

protocol ReplyViewControllerDelegate: class {
    func didPostReply(post: Tweet)
}

class ReplyViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    weak var delegate: ReplyViewControllerDelegate?
    
    var replyToUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        replyTextView.delegate = self
        
        screenNameLabel.text = replyToUser?.screenName
        let validURL = replyToUser?.profPicURL
        if (validURL != nil) {
            profileImageView.af_setImage(withURL: validURL!)
        }
        
        

    }

    @IBAction func onReply(_ sender: Any) {
        APIManager.shared.composeTweet(with: replyTextView.text) { (tweet, error) in
            if let error = error {
                print("Error composing reply Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                //self.delegate?.didPost(post: tweet)
                print("Compose reply Tweet Success!")
            }
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func onDismiss(_ sender: Any) {
        self.dismiss(animated: true) { 
            print("user dismissed")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
