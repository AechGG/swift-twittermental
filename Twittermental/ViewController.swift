//
//  ViewController.swift
//  Twittermental
//
//  Created by Harrison Gittos on 03/09/2020.
//  Copyright © 2020 Harrison Gittos. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let sentimentClassifier = TweetSentimentClassifier();
    
    var swifter = Swifter(consumerKey: K.TWITTER_CONSUMER_KEY, consumerSecret: K.TWITTER_CONSUMER_SECRET);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
            
            var tweets = [TweetSentimentClassifierInput]();
            
            for i in 0..<100 {
                if let tweet = results[i]["full_text"].string {
                    let tweetType = TweetSentimentClassifierInput(text: tweet);
                    tweets.append(tweetType);
                }
            }
            
            do {
                let predictions = try self.sentimentClassifier.predictions(inputs: tweets);
                
                var sentimentScore = 0;
                
                for pred in predictions {
                    let sentiment = pred.label;
                    if sentiment == "Pos" {
                        sentimentScore += 1
                    } else if sentiment == "Neg" {
                        sentimentScore -= 1;
                    }
                }
            } catch {
                print("Error carrying out prediction \(error)");
            }
            
            
            
        }) { (error) in
            print("Error retrieving tweets: \(error)")
        }
    }
    
    @IBAction func predictPressed(_ sender: UIButton) {
    }
    
}

