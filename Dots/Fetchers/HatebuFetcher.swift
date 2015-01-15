//
//  HatebuHelper.swift
//  Memory
//
//  Created by knmsyk on 8/9/14.
//  Copyright (c) 2014 knmsyk. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import Timepiece

class HatebuFetcher: NSObject {

    class func fetchData(date: NSDate) {
        let url = "http://b.hatena.ne.jp/\(Constants.Account.Hatena)/atomfeed"
        let params = ["date" : Utility.stringFromDate("yyyyMMdd", date: date)]
        
        Alamofire.request(.GET, url, parameters: params)
            .responseString { (request, response, data, error) in
                if response?.statusCode == 200 && data != nil {
                    self.parseXml(data!)                    
                }
        }
    }
    
    class func parseXml(data: String!) {
        let xml = SWXMLHash.parse(data)
        
        let app = UIApplication.sharedApplication().delegate as AppDelegate
        let className = "Dot"
        var error: NSError?
        let fetchRequest = NSFetchRequest(entityName:className)
        
        outerLoop: for entry in xml["feed"]["entry"] {
            let id = entry["id"].element?.text

            fetchRequest.predicate = NSPredicate(format: "id == %@", id!)
            let dots = app.cdh.managedObjectContext!.executeFetchRequest(fetchRequest, error: &error)
            for dot in dots! {
                let dot = dot as Dot
                continue outerLoop
            }
            
            var dot: Dot = NSEntityDescription.insertNewObjectForEntityForName(className, inManagedObjectContext: app.cdh.backgroundContext!) as Dot
            dot.id = id!
            if let title = entry["title"].element?.text {
                dot.title = title
            }
            if let text = entry["summary"].element?.text {
                dot.text = text
            }
            if let url = entry["link"].withAttr("rel", "related").element?.attributes["href"] {
                dot.url = url
            }
            if let date = entry["issued"].element?.text {
                dot.created_at = Utility.dateFromStringFormat("yyyy-MM-dd'T'HH:mm:ssZ", datetime: date)
            }
        }
        app.cdh.saveContext()
    }
    
}
