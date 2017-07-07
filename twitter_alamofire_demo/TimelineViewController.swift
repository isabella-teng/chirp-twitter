//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit


class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate, UIScrollViewDelegate, ReplyViewControllerDelegate, TweetCellDelegate {
    
    var tweets: [Tweet] = []
    var profileUser: User?
    
    @IBOutlet weak var tableView: UITableView!
    
    //For infinite scrolling
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScroll?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 200//UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        //Infinite scroll activity indicator
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScroll.defaultHeight)
        loadingMoreView = InfiniteScroll(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset
        insets.bottom += InfiniteScroll.defaultHeight
        tableView.contentInset = insets
        
        getTweets()
    
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TimelineViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Handle scroll behavior here
        if (!isMoreDataLoading) {
            //Calculate position of one screen length before bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffSetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffSetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                
                //Update position of loadingMoreView, start loading indicator
                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScroll.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                loadMoreData()
            }
        }
    }
    
    func loadMoreData() {
        getTweets()
        let lastTweet = tweets[tweets.count - 1]
        APIManager.shared.saveMaxID(lastTweetID: "\(lastTweet.id)")
        
        loadingMoreView!.stopAnimating()
        tableView.reloadData()
        isMoreDataLoading = false
    }
    
    func getTweets() {
    
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        getTweets()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        //round profile pic corners
        cell.userProfilePic.layer.cornerRadius = 15
        cell.userProfilePic.clipsToBounds = true
        
        cell.tweet = tweets[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tweetCell(_ tweetCell: TweetCell, didTap user: User) {
        //Perform segue to profile view controller
        performSegue(withIdentifier: "profileSegue", sender: user)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogoutButton(_ sender: Any) {
        
        APIManager.shared.logout()
        
    }
    
    func didPost(post: Tweet) {
        tweets.insert(post, at: 0)
        self.tableView.reloadData()
    }
    
    func didPostReply(post: Tweet) {
        print("replied to user")
    }
    
    @IBAction func onReplyButton(_ sender: Any) {
        performSegue(withIdentifier: "replySegue", sender: profileUser)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "composeSegue") {
            let composeViewController = segue.destination as! ComposeViewController
            //variable for the timelineviewcontroller
            composeViewController.delegate = self
        } else if (segue.identifier == "replySegue") {
            let replyViewController = segue.destination as! ReplyViewController
            replyViewController.delegate = self
            //if sender
            //replyViewController.replyToUser = sender as! User
        } else if (segue.identifier == "profileSegue") {
            let vc = segue.destination as! ProfileViewController
            vc.profileUser = sender as! User
        
        }
        
        
    }

    
}
