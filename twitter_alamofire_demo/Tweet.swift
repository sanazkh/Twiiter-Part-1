//
//  Tweet.swift
//  twitter_alamofire_demo
//
//  Created by Sanaz Khosravi on 10/11/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import Foundation
class Tweet {
    
    // MARK: Properties
    var id: Int64?
    var text: String
    var favoriteCount: Int
    var replyCount : Int
    var favorited: Bool?
    var retweetCount: Int
    var retweeted: Bool
    var user: User
    var createdAtString: String?
    var idString: String?
    
    // For Retweets
    var retweetedByUser: User?  // user who retweeted if tweet is retweet
    
    init(dictionary: [String: Any]) {
        var dictionary = dictionary
        
        if let originalTweet = dictionary["retweeted_status"] as? [String: Any] {
            let userDictionary = dictionary["user"] as! [String: Any]
            self.retweetedByUser = User(dictionary: userDictionary)
            
            //Change tweet to original tweet
            dictionary = originalTweet
        }
        
        if let twitid: NSNumber = dictionary["id"] as? NSNumber{
            id = twitid.int64Value
        }
        
        text = dictionary["text"] as! String
        favoriteCount = (dictionary["favorite_count"] as? Int) ?? 0
        
        replyCount = (dictionary["reply_count"] as? Int) ?? 0
        
        favorited = dictionary["favorited"] as? Bool
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        retweeted = dictionary["retweeted"] as! Bool
        idString = (dictionary["id_str"] as? String) ?? ""
        
        let user = dictionary["user"] as! [String: Any]
        self.user = User(dictionary: user)
        
        // Format createdAt date string
        let createdAtOriginalString = dictionary["created_at"] as! String
        let formatter = DateFormatter()
        // Configure the input format to parse the date string
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        // Convert String to Date
        let date = formatter.date(from: createdAtOriginalString)!
        // Configure output format
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        // Convert Date to String and set the createdAtString property
        createdAtString = formatter.string(from: date)
    }
    
    static func tweets(with array: [[String: Any]]) -> [Tweet] {
        var tweets: [Tweet] = []
        for tweetDictionary in array {
            let tweet = Tweet(dictionary: tweetDictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}
