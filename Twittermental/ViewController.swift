//
//  ViewController.swift
//  Twittermental
//
//  Created by Harrison Gittos on 03/09/2020.
//  Copyright © 2020 Harrison Gittos. All rights reserved.
//

import UIKit
import SwifteriOS

class ViewController: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    var swifter = Swifter(consumerKey: K.TWITTER_CONSUMER_KEY, consumerSecret: K.TWITTER_CONSUMER_SECRET);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
            print(results);
        }) { (error) in
            print("Error retrieving tweets: \(error)")
        }
    }
    
    @IBAction func predictPressed(_ sender: UIButton) {
    }
    
}

