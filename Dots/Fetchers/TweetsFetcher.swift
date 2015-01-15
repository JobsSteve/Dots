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
    
    let failureHandler: ((NSError) -> Void) = {
        error in
        println("Error:" + error.localizedDescription)
    }
    
    func fetchOwnTweets() {
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
        self.swifter.getFavoritesListWithCount(fetchCounts, sinceID: nil, maxID: nil, success: {
            (statuses: [JSONValue]?) in
            
            if let statuses = statuses {
                self.parseTweets(statuses)
            };
            
            }, failure: failureHandler)
    }
    
    func parseTweets(statuses: [JSONValue]) {
        let app = UIApplication.sharedApplication().delegate as AppDelegate
        var error: NSError?
        let fetchItemRequest = NSFetchRequest(entityName:"Item")
        let fetchUserRequest = NSFetchRequest(entityName:"User")
        
        outerLoop: for status: JSONValue in statuses {
            // Item
            let id = status["id_str"].string!
            fetchItemRequest.predicate = NSPredicate(format: "id == %@", id)
            let results = app.cdh.managedObjectContext!.executeFetchRequest(fetchItemRequest, error: &error)
            for resultItem in results! {
                continue outerLoop
            }
            var item: Item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: app.cdh.managedObjectContext!) as Item
            item.id = id
            item.text = status["text"].string!
            if status["entities"]["urls"][0] {
                item.url = status["entities"]["urls"][0]["expanded_url"].string!
            }
            if status["entities"]["media"][0] {
                item.picture = status["entities"]["media"][0]["media_url"].string!
            }
            item.created_at = Utility.dateFromStringFormat("eee MMM dd HH:mm:ss ZZZZ yyyy", datetime: status["created_at"].string!)
            
            // User
            let userId = status["user"]["id_str"].string!
            fetchUserRequest.predicate = NSPredicate(format: "id == %@", userId)
            let users = app.cdh.managedObjectContext!.executeFetchRequest(fetchUserRequest, error: &error)
            for user in users! {
                item.user = user as? User
                continue outerLoop
            }
            var user: User = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: app.cdh.managedObjectContext!) as User
            user.id = userId
            if let screen = status["user"]["screen_name"].string {
                user.screen_name = screen
            }
            if let name = status["user"]["name"].string {
                user.name = name
            }
            if let image = status["user"]["profile_image_url"].string {
                user.picture = image
            }
            if let url = status["user"]["url"].string {
                user.url = url
            }
            item.user = user
        }
        app.cdh.saveContext(app.cdh.managedObjectContext!)
    }
}
