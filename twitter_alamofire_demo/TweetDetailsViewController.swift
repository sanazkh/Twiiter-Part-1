//
//  TweetDetailsViewController.swift
//  twitter_alamofire_demo
//
//  Created by Sanaz Khosravi on 10/19/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetDetailsViewController: UIViewController {
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var tweetLabel: UITextView!
    @IBOutlet weak var userAvatarButton: UIButton!
    @IBOutlet weak var repliesLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameButton.setTitle("\((tweet?.user.name)!)", for: .normal)
        self.screennameLabel.text = "@\((tweet?.user.screenName)!)"
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute]
        formatter.unitsStyle = .brief
        self.timeLabel.text = tweet?.createdAtString
        self.tweetLabel.text = "\((tweet?.text)!)"
        self.favoritesLabel.text = "\((tweet?.favoriteCount)!)"
        self.repliesLabel.text = "0"
        self.retweetLabel.text = "\((tweet?.retweetCount)!)"
        
        let avatarUrl = URL(string: "\((tweet?.user.profilepic)!)")
        self.userAvatarButton.setTitle("", for: .normal)
        self.avatarImageView.af_setImage(withURL: avatarUrl!)
        
        if (tweet?.favorited)! {
            self.favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        } else {
            self.favoriteButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
        
        if (tweet?.retweeted)! {
            self.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        } else {
            self.retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        }
        
        self.replyButton.setImage(UIImage(named: "reply-icon"), for: .normal)
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
