//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import MBProgressHUD

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,ComposeViewControllerDelegate  {
    
    func did(post: Tweet) {
        fetchTweets()
    }
    
    
    @IBAction func logOutButton(_ sender: Any) {
        APIManager.shared.logout()
    }
    var tweets: [Tweet]!
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
       
        fetchTweets()
    }

    
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        fetchTweets()
        
    }
    func fetchTweets(){
        APIManager.shared.getHomeTimeLine { (tweets: [Tweet]?, error: Error?) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            }
            self.refreshControl.endRefreshing()
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetViewCell") as! TweetViewCell
        let tweet = tweets[indexPath.row]
        cell.tweet = tweet
        cell.user = tweet.user
        cell.indexPath = indexPath
        cell.parentView = self as TimelineViewController
//        cell.favoritesLabel.text = "\((tweet.favoriteCount))"
//        cell.repliesLabel.text = "\((tweet.replyCount))"
//
//        cell.retweetsLabel.text = "\((tweet.retweetCount))"
//        cell.usernameButton.setTitle("\((tweet.user.name)!)", for: .normal)
//        cell.scrennameLabel.text = "@\((tweet.user.screenName)!)"
//
//        let formatter = DateComponentsFormatter()
//        formatter.allowedUnits = [.year, .month, .day, .hour, .minute]
//        formatter.unitsStyle = .brief
//        cell.timeLabel.text = tweet.createdAtString
//
//        let avatarUrl = tweet.user.profilepic
//        cell.avatarButton.setTitle("", for: .normal)
//        cell.avatarImageView.af_setImage(withURL: avatarUrl!)
//
//
//        if (tweet.favorited)! {
//            cell.favoritesButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
//        } else {
//            cell.favoritesButton.setImage(UIImage(named: "favor-icon"), for: .normal)
//        }
//
//        if (tweet.retweeted) {
//            cell.retweetsButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
//        } else {
//            cell.retweetsButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
//        }
//
//        cell.tweetLabel.text = tweet.text
//
//        cell.replyButton.setImage(UIImage(named: "reply-icon"), for: .normal)
//
//        cell.idString = tweet.idString
        

        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let indexPath = tableView.indexPath(for: cell)
        if (segue.identifier == "goToTweetDetails") {
            let tweet = tweets[(self.tableView.indexPathForSelectedRow?.row)!]
            let detailViewController = segue.destination as! TweetDetailsViewController
            detailViewController.tweet = tweet
        }else if (segue.identifier == "profileFromFeed" || segue.identifier == "profileFromDetails" || segue.identifier == "profileFromAvatar") {
            let usernameButton = sender as! UIButton
            let location = usernameButton.imageView!.convert(CGPoint.zero, to: self.tableView)
            let indexPath = tableView.indexPathForRow(at: location)
            let tweet = self.tweets[(indexPath?.row)!]
            let profileVC = segue.destination as! ProfileViewController
            profileVC.user = tweet.user
            print("\(tweet.user.screenName)")
        } else if (segue.identifier == "selfFromFeed") {
            let profileVC = segue.destination as! ProfileViewController
            profileVC.user = User.current!
        }
}

}
