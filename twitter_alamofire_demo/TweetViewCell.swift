//
//  TableViewCell.swift
//  twitter_alamofire_demo
//
//  Created by Sanaz Khosravi on 10/11/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//


import UIKit

class TweetViewCell: UITableViewCell {
    
    
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var scrennameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var repliesLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var retweetsButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var parentView: TimelineViewController?
    var indexPath : IndexPath?
    var idString: String?
    
    var favorited: Bool = false
    var retweeted: Bool = false
    
    
    var tweet : Tweet! {
        didSet{
            print("hiiii push to git" + (tweet?.createdAtString)!)
            timeLabel.text = tweet?.createdAtString
            tweetLabel.text = tweet?.text
            usernameButton.setTitle("\((tweet?.user.name)!)", for: .normal)
            replyButton.setImage(UIImage(named: "reply-icon"), for: .normal)
            repliesLabel.text = "\((tweet.replyCount))"
            self.updateFavoriteReTweetDetails(tweet: tweet!)
        }
    }
    
    var user : User? {
        didSet{
            scrennameLabel.text = "@\(user?.screenName ?? "noHandle")"
            if let propicURL = user?.profilepic {
                avatarImageView.af_setImage(withURL: propicURL)
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
        
    }

    
}
