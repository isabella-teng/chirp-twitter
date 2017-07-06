//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Isabella Teng on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate: class {
    func didPost(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var tweetTextView: UITextView!
    
    weak var delegate: ComposeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.delegate = self
    }
    
    //for placeholder text
    var firstTextEdit: Bool = true
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == tweetTextView && firstTextEdit {
            textView.text = ""
            firstTextEdit = false
        }
        textView.textColor = UIColor.black
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        self.dismiss(animated: true) { 
            print("User cancelled post")
        }
    }
    
    @IBAction func onPostButton(_ sender: Any) {
        //let fullTweet = tweetTextView.text!
        print(tweetTextView.text)
        APIManager.shared.composeTweet(with: tweetTextView.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.didPost(post: tweet)
                print("Compose Tweet Success!")
            }
        }
        
        self.dismiss(animated: true)
    }
    
//    func didPost(post: Tweet) {
//        print("tweet has posted")
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            let composeViewController = segue.destination as! ComposeViewController
//            //variable for the timelineviewcontroller
//        
//            composeViewController.delegate = self
//    }

        
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
