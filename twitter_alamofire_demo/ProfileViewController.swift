//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Sanaz Khosravi on 10/19/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var detailLabelView: UIView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var statusCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var user : User?
    var tweets: [Tweet] = []
    
    /*  @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
   
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var profileImageView: UIImageView!
    
    
    @IBOutlet var screennameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var user: User?
    var tweets: [Tweet]? */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(user?.name)
        detailLabelView.layer.borderWidth = 0.5
        circularProfilePicture()
        loadProfileInfo()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
      /*  APIManager.shared.getHomeTimeLine { (tweets: [Tweet]?, error: Error?) in
            if let tweets = tweets {
                self.tweets = tweets
            }
        }
        
        self.navigationController?.title = user?.name
        
        usernameLabel.text = user?.name!
        fullNameLabel.text = user?.screenName! */
        
        //        let avatarUrl = tweet.user.profilepic
        //        cell.avatarButton.setTitle("", for: .normal)
        //        cell.avatarImageView.af_setImage(withURL: avatarUrl!)
        
      /*  let avatarUrl = URL(string: "\((user?.profilepic)!))")
        print((user?.profilepic)!)
        self.profileImageView.af_setImage(withURL: URL(string: "\((user?.profilepic)!))")!)
        
        let backgroundUrl = URL(string: "\((user?.bannerpic))")
        print((user?.bannerpic))
        backgroundImageView.af_setImage(withURL: URL(string: "\((user?.bannerpic))")!)
        
        tweetCountLabel.text = "\((user?.statusCount)!)"
        followingCountLabel.text = "\((user?.followingCount)!)"
        followersCountLabel.text = "\((user?.followercount)!)" */
        
    }
    
    func loadProfileInfo(){
        if let user = self.user {
            usernameLabel.text = user.screenName!
            if user.name != nil {
                fullNameLabel.text = user.name
            }
            followersCountLabel.text = "\(user.followercount!)"
            followingCountLabel.text = "\(user.friendcount!)"
            statusCountLabel.text = "\(user.statusCount!)"
            if let propicURL = user.profilepic {
                profileImageView.af_setImage(withURL: propicURL)
            }
            if let bannerURL = user.bannerpic {
                bannerImageView.af_setImage(withURL: bannerURL)
            }
            fetchTweets()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func circularProfilePicture() {
        profileImageView.layer.cornerRadius = profileImageView.layer.frame.height/2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 1.5
        profileImageView.layer.borderColor = UIColor.black.cgColor
    }
    
    func fetchTweets() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return tweets.count
        /*  if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        } */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetViewCell
        
        cell.tweet = tweets[indexPath.row]
        cell.user = self.user
        //cell.parentView = self as ProfileViewController
        cell.indexPath = indexPath
        
        return cell
        /* let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTweetCell") as! TweetViewCell
        let tweet = tweets?[indexPath.row]
        let avatarUrl = URL(string: "\(user?.profilepic!)")
        if let pictureData = NSData(contentsOf: avatarUrl!) {
            let image = UIImage(data: pictureData as Data)
            cell.avatarButton.setImage(image, for: .normal)
        }
        cell.avatarButton.af_setImage(for: .normal, url: avatarUrl!)
        
        cell.favoritesLabel.text = "\((tweet?.favoriteCount))"
        cell.repliesLabel.text = "\((tweet?.replyCount))"
        cell.retweetsLabel.text = "\((tweet?.retweetCount))"
        
        return cell */
    }
    
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "selfFromProfile") {
            let profileVC = segue.destination as! ProfileViewController
            profileVC.user = User.current!
        }
    }
    
}
