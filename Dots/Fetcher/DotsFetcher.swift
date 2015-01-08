//
//  DotsFetcher.swift
//  Dots
//
//  Created by knmsyk on 1/2/15.
//  Copyright (c) 2015 knmsyk. All rights reserved.
//

import Foundation
import Timepiece

class DotsFetcher {
    
    class func fetch() {
        let tweetsFetcher = TweetsFetcher()
        tweetsFetcher.setUpTwitterAccount()
        
        let today = NSDate.today()
        for day in [1, 3, 7, 30] {
            let ago = today - day.days
            HatebuFetcher.fetchData(ago)
            BloggerFetcher.fetchData(ago)
        }        
    }
    
    //    class func fetchGoogleHistory() {
    //    }

    //    class func fetchQiita() {
    //    }

    //    class func fetchEvernote() {
    //    }

}
