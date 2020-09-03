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

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var sentimentLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    let sentimentClassifier = TweetSentimentClassifier();

    
    var swifter = Swifter(consumerKey: K.TWITTER_CONSUMER_KEY, consumerSecret: K.TWITTER_CONSUMER_SECRET);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
    }
    
    @IBAction func predictPressed(_ sender: UIButton) {
        if let searchText = inputTextField.text {
            getSentiment(searchText);
        }
    }
    
    private func getSentiment(_ text: String) {
        swifter.searchTweet(using: text, lang: K.TWITTER_LANG, count: K.TWITTER_TWEET_COUNT, tweetMode: .extended, success: { (results, metadata) in
            
            var tweets = [TweetSentimentClassifierInput]();
            
            for i in 0..<K.TWITTER_TWEET_COUNT {
                if let tweet = results[i]["full_text"].string {
                    let tweetType = TweetSentimentClassifierInput(text: tweet);
                    tweets.append(tweetType);
                }
            }
            
            self.makePrediction(tweets);
            
        }) { (error) in
            print("Error retrieving tweets: \(error)")
        }
    }
    
    private func makePrediction(_ tweets: [TweetSentimentClassifierInput]) {
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
            
            self.setSentimentLabel(sentimentScore);
            
        } catch {
            print("Error carrying out prediction \(error)");
        }
    }
    
    private func setSentimentLabel(_ sentimentScore: Int) {
        if sentimentScore > 20 {
            self.sentimentLabel.text = "😍";
        } else if sentimentScore > 10 {
            self.sentimentLabel.text = "😀";
        } else if sentimentScore > 0 {
            self.sentimentLabel.text = "🙂";
        } else if sentimentScore == 0 {
            self.sentimentLabel.text = "😐";
        } else if sentimentScore > -10 {
            self.sentimentLabel.text = "🙁";
        } else if sentimentScore > -20 {
            self.sentimentLabel.text = "😡";
        } else {
            self.sentimentLabel.text = "🤮";
        }
    }
    
}

