//
//  DotsFetcher.swift
//  Dots
//
//  Created by Kouno, Masayuki on 1/2/15.
//  Copyright (c) 2015 Kouno, Masayuki. All rights reserved.
//

import Foundation

class DotsFetcher {
    
    class func fetchAll() {
        self.fetchTweets()
        self.fetchHatenaBookmark()
    }
    
    class func fetchTweets() {
        let tweetsFetcher = TweetsFetcher()
        tweetsFetcher.setUpTwitterAccount()
    }
    
    class func fetchHatenaBookmark() {
    }
    
    //    class func fetchGoogleHistory() {
    //    }
    
}
