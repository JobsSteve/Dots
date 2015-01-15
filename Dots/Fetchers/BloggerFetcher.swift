//
//  BloggerFetcher.swift
//  Dots
//
//  Created by knmsyk on 1/4/15.
//  Copyright (c) 2015 knmsyk. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON
import Timepiece

// TODO: Update to ver3 api of blogger
// https://developers.google.com/blogger/docs/3.0/reference/posts/list

class BloggerFetcher: NSObject {
    
    class func fetchData(date: NSDate) {
        let format = "yyyy-MM-dd'T'HH:mm:ss'+09:00'"
        let start = Utility.stringFromDate(format, date: date)
        let end = Utility.stringFromDate(format, date: date.endOfDay)
        let url = "http://\(Constants.Account.Blogger).blogspot.com/feeds/posts/default"
        let params = ["published-min" : start, "published-max": end, "orderby": "updated", "alt": "json"]
        
        Alamofire.request(.GET, url, parameters: params)
            .responseJSON { (request, response, data, error) in
                if response?.statusCode == 200 && data != nil {
                    self.parseJSON(JSON(data!))                    
                }
        }
    }
    
    class func parseJSON(json: JSON) {
        for entry in json["feed"]["entry"].arrayValue {
            if let id = entry["id"]["$t"].string {
                println(id)
            }
            if let title = entry["title"]["$t"].string {
                println(title)
            }
            if let date = entry["published"]["$t"].string {
                println(date)
            }
            if let text = entry["content"]["$t"].string {
                println(text)
            }
            if let url = entry["link"][2]["href"].string {
                println(url)
            }
        }
    }
}