//
//  TweetsFetcher.swift
//  Dots
//
//  Created by Kouno, Masayuki on 1/2/15.
//  Copyright (c) 2015 Kouno, Masayuki. All rights reserved.
//

import UIKit
import Twitter
import Accounts
import SwifteriOS
import CoreData

class TweetsFetcher: NSObject {
    
    var swifter: Swifter
    
    required override init() {
        self.swifter = Swifter(consumerKey: "RErEmzj7ijDkJr60ayE2gjSHT", consumerSecret: "SbS0CHk11oJdALARa7NDik0nty4pXvAxdt7aj0R5y1gNzWaNEx")
        super.init()
    }

    func setUpTwitterAccount() {
        // TODO: if already have twitter account
        // return
        
        // else
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
                let twitterAccount = twitterAccounts[0] as ACAccount
                self.swifter = Swifter(account: twitterAccount)
                self.fetchAll()
            }
        }
    }
    
    func fetchAll() {
        fetchFavorites()
        fetchOwnTweets()
    }
    
    func fetchOwnTweets() {
        
    }
    
    func fetchFavorites() {
        let failureHandler: ((NSError) -> Void) = {
            error in
            println("Error:" + error.localizedDescription)
        }
        
        self.swifter.getFavoritesListWithCount(20, sinceID: nil, maxID: nil, success: {
            (statuses: [JSONValue]?) in
            
            if let statuses = statuses {
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
                    
                    println(status)
                }
                delegate.saveContext()
            };
            
            }, failure: failureHandler)
    }
    
}
