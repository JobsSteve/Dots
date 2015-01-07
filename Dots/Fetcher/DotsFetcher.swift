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
        let lastFetchKey = "last_fetch_date"
        let date = NSUserDefaults.standardUserDefaults().objectForKey(lastFetchKey) as NSDate?
        if date?.compare(3.hours.ago) == NSComparisonResult.OrderedDescending {
            return
        }
        
        let tweetsFetcher = TweetsFetcher()
        tweetsFetcher.setUpTwitterAccount()
        
        let today = NSDate.today()
        for day in [1, 3, 7, 30] {
            let ago = today - day.days
            HatebuFetcher.fetchData(ago)
            BloggerFetcher.fetchData(ago)
        }
        
        NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey:lastFetchKey)
    }
    
    //    class func fetchGoogleHistory() {
    //    }

    //    class func fetchQiita() {
    //    }

    //    class func fetchEvernote() {
    //    }

}
