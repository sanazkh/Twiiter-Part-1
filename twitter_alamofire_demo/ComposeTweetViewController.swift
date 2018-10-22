//
//  ComposeTweetViewController.swift
//  twitter_alamofire_demo
//
//  Created by Sanaz Khosravi on 10/19/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit



protocol ComposeViewControllerDelegate : class {
    func did(post: Tweet)
} 
class ComposeTweetViewController: UIViewController, UITextViewDelegate {

   
    @IBOutlet var myTextField: UITextView!
    
    @IBOutlet var charCount: UILabel!
    @IBOutlet weak var tweetStatusLabel: UILabel!
    @IBOutlet weak var tweetButton: UIButton!
    weak var delegate: ComposeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetStatusLabel.isHidden = true
        myTextField.text = ""
        myTextField.delegate = self
        charCount.text = "0"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        charCount.text = "\(newText.characters.count)"
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
    }
    
    @IBAction func onTweetButton(_ sender: Any) {
        if ((myTextField.text?.characters.count)! > 140) {
            tweetStatusLabel.isHidden = false
            tweetStatusLabel.text = "Error,\((myTextField.text?.characters.count)!) characters."
            tweetStatusLabel.textColor = UIColor.red
            
        } else {
        APIManager.shared.composeTweet(with: myTextField.text!) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                self.myTextField.isEditable = false
                self.tweetStatusLabel.isHidden = false
                print("Compose Tweet Success!")
            }
        }
    }
}
    
}
