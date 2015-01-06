//
//  TweetsFetcher.swift
//  Dots
//
//  Created by knmsyk on 1/2/15.
//  Copyright (c) 2015 knmsyk. All rights reserved.
//

import UIKit
import Twitter
import Accounts
import SwifteriOS
import CoreData

class TweetsFetcher: NSObject {
    
    var swifter: Swifter
    let fetchCounts = 30
    
    required override init() {
        self.swifter = Swifter(consumerKey: Constants.Twitter.ConsumerKey, consumerSecret: Constants.Twitter.SecretKey)
        super.init()
    }

    func setUpTwitterAccount() {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) {
            granted, error in
            if !granted {
                return
            }
            
            let twitterAccounts = accountStore.accountsWithAccountType(accountType)
            if twitterAccounts.count == 0 {
                println("No Twitter accounts.")
            } else {
                for twitterAccount in twitterAccounts {
                    let twitterAccount = twitterAccount as ACAccount
                    self.swifter = Swifter(account: twitterAccount)
                    self.fetch()
                }
            }
        }
    }
    
    func fetch() {
        fetchFavorites()
        fetchOwnTweets()
    }
    
    func fetchOwnTweets() {
        let failureHandler: ((NSError) -> Void) = {
            error in
            println("Error:" + error.localizedDescription)
        }
        
        if let t = self.swifter.client.credential?.account {
            let properties = t.valueForKey("properties") as NSDictionary
            let userId = properties["user_id"] as String
            self.swifter.getStatusesUserTimelineWithUserID(userId, count: fetchCounts, sinceID: nil, maxID: nil, trimUser: false, contributorDetails: false, includeEntities: true, success: {
                (statuses: [JSONValue]?) in
                
                if let statuses = statuses {
                    self.parseTweets(statuses)
                };
                
                }, failure: failureHandler)
        }
    }
    
    func fetchFavorites() {
        let failureHandler: ((NSError) -> Void) = {
            error in
            println("Error:" + error.localizedDescription)
        }
        
        self.swifter.getFavoritesListWithCount(fetchCounts, sinceID: nil, maxID: nil, success: {
            (statuses: [JSONValue]?) in
            
            if let statuses = statuses {
                self.parseTweets(statuses)
            };
            
            }, failure: failureHandler)
    }
    
    func parseTweets(statuses: [JSONValue]) {
        let delegate = UIApplication.sharedApplication().delegate as AppDelegate
        let className = "Item"
        var error: NSError?
        let fetchRequest = NSFetchRequest(entityName:className)
        
        outerLoop: for status: JSONValue in statuses {
            let id = status["id_str"].string!
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            let results = delegate.managedObjectContext!.executeFetchRequest(fetchRequest, error: &error)
            for resultItem in results! {
                let item = resultItem as Item
                continue outerLoop
            }
            
            var item: Item = NSEntityDescription.insertNewObjectForEntityForName(className, inManagedObjectContext: delegate.managedObjectContext!) as Item
            item.id = id
            item.text = status["text"].string!
            if status["entities"]["urls"][0] {
                item.url = status["entities"]["urls"][0]["expanded_url"].string!
            }
            if status["entities"]["media"][0] {
                item.picture = status["entities"]["media"][0]["media_url"].string!
            }
            item.date = NSDate()
        }
        delegate.saveContext()
    }
}
