//
//  ProfileTweetsTableViewCell.swift
//  twitter_alamofire_demo
//
//  Created by Sanaz Khosravi on 10/19/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire

class ProfileTweetsTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
  /*  @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var repliesButton: UIButton!
    @IBOutlet weak var repliesLabel: UILabel!
    @IBOutlet weak var retweetsButton: UIButton!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    var parentView: TimelineViewController?
    var indexPath : IndexPath?
    var idString: String?
    
    var favorited: Bool = false
    var retweeted: Bool = false
    
    var tweet : Tweet! {
        didSet{
            timestampLabel.text = tweet?.createdAtString
            tweetLabel.text = tweet?.text
            usernameButton.setTitle("\((tweet?.user.name)!)", for: .normal)
            repliesButton.setImage(UIImage(named: "reply-icon"), for: .normal)
            repliesLabel.text = "\((tweet.replyCount))"
            self.updateFavoriteReTweetDetails(tweet: tweet!)
        }
    }
    
    var user : User? {
        didSet{
            screennameLabel.text = "@\(user?.screenName ?? "noHandle")"
            if let propicURL = user?.profilepic {
                avatarButton.af_setImage(for: .normal, url: propicURL)
            }
        }
    }
    
    
    
    
    func updateFavoriteReTweetDetails(tweet: Tweet) {
        if(tweet.favorited == true){
            self.favoritesButton.setImage(UIImage(named: "favor-icon-red.png"), for: .normal)
        } else {
            self.favoritesButton.setImage(UIImage(named: "favor-icon.png"), for: .normal)
        }
        self.favoritesLabel.text = "\(tweet.favoriteCount)"
        
        if(tweet.retweeted == true){
            self.retweetsButton.setImage(UIImage(named: "retweet-icon-green.png"), for: .normal)
        } else {
            self.retweetsButton.setImage(UIImage(named: "retweet-icon.png"), for: .normal)
        }
        self.retweetsLabel.text = "\(tweet.retweetCount )"
    }
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onFavoriteButton(_ sender: Any) {
        if (tweet!.favorited == false) {
            APIManager.shared.favorite(self.tweet!) { (post, error) in
                if let  error = error {
                    print("Error Favoriting Tweet: \(error.localizedDescription)")
                } else {
                    self.parentView?.fetchTweets()
                }
            }
        }
        else {
            APIManager.shared.unfavorite(self.tweet!) { (post, error) in
                if let  error = error {
                    print("Error Favoriting Tweet: \(error.localizedDescription)")
                } else {
                    self.parentView?.fetchTweets()
                }
            }
        }
    }
    
    @IBAction func onRetweetButton(_ sender: Any) {
        if (tweet!.retweeted == false) {
            APIManager.shared.retweet(self.tweet!) { (post, error) in
                if let  error = error {
                    print("Error retweeting Tweet: \(error.localizedDescription)")
                } else {
                    self.parentView?.fetchTweets()
                }
            }
        }
        else {
            APIManager.shared.unretweet(self.tweet!) { (post, error) in
                if let  error = error {
                    print("Error unretweeting Tweet: \(error.localizedDescription)")
                } else {
                    self.parentView?.fetchTweets()
                }
            }
        }
    } */

}
