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
        
//        let prediction = try! sentimentClassifier.prediction(text: "test");
//
//        print(prediction.label);
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
            
            var tweets = [String]();
            
            for i in 0..<100 {
                if let tweet = results[i]["full_text"].string {
                    tweets.append(tweet);
                }
            }
            
            
            
        }) { (error) in
            print("Error retrieving tweets: \(error)")
        }
    }
    
    @IBAction func predictPressed(_ sender: UIButton) {
    }
    
}

