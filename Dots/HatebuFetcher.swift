//
//  HatebuHelper.swift
//  Memory
//
//  Created by Kouno, Masayuki on 8/9/14.
//  Copyright (c) 2014 Kouno, Masayuki. All rights reserved.
//

import Foundation
import Alamofire

protocol HatebuHelperDelegate {
    func hatebuDelegateDidFetch(data: [Dictionary<String, String?>], isSuccess: Bool)
}

class HatebuFetcher: NSObject {

//    var contentData: [Dictionary<String, String?>] = [Dictionary]()
//    var delegate: HatebuHelperDelegate?
    
    class func fetch() {
        fetchData(NSDate())
        let day = 60*60*24 as NSTimeInterval;
        fetchData(NSDate().dateByAddingTimeInterval(-1 * day))
    }
    
    class func fetchData(date: NSDate) {
//        let url = "http://sumoftimery.blogspot.com/feeds/posts/default?published-min=%sT00:00:00%2B09:00&published-max=%sT23:59:59%2B09:00&orderby=updated";
        let url = "http://b.hatena.ne.jp/shougyou/atomfeed"
        let params = ["date" : Utility.stringFromDate("yyyyMMdd", date: date)]
        
        Alamofire.request(.GET, url, parameters: params)
            .responseString { (request, response, data, error) in
                println(request)
                println(response)
                println(response?.statusCode)
                println(data)
        }
        
//        let manager = AFHTTPRequestOperationManager();
//        manager.responseSerializer = AFXMLParserResponseSerializer()
//        manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/atom+xml")
//        manager.GET(
//            url,
//            parameters: params,
//            success: {
//                (operation: AFHTTPRequestOperation!, response: AnyObject!) in
//                let parser = response as NSXMLParser
//                let dicParser = XMLDictionaryParser()
//                let array = dicParser.dictionaryWithParser(parser)
//                if !array["entry"] {
//                    self.delegate?.hatebuDelegateDidFetch(self.contentData, isSuccess: true)
//                    return;
//                }
//                let entryObject: AnyObject? = array["entry"]
//                let title = array["title"] as AnyObject? as String?
//                let isOneEntry = title!.hasSuffix("(1)") || title! == "ブックマーク"
//                if isOneEntry {
//                    let entries = entryObject as NSDictionary?
//                    self.addEntryToData(entries)
//                } else {
//                    let entries = entryObject as NSArray?
//                    for var i = 0; i < entryObject?.count; i++ {
//                        let entry = entries?.objectAtIndex(i) as NSDictionary?
//                        self.addEntryToData(entry)
//                    }
//                }
//                println(self.contentData)
//                self.delegate?.hatebuDelegateDidFetch(self.contentData, isSuccess: true)
//            },
//            failure: {
//                (operation: AFHTTPRequestOperation!, error: NSError!) in
//                self.contentData = [Dictionary]()
//                self.delegate?.hatebuDelegateDidFetch(self.contentData, isSuccess: false)
//                println(error)
//            }
//        )
    }
    
    func addEntryToData(entry: NSDictionary?) {
//        let title : String? = entry?.objectForKey("title") as AnyObject? as String?
//        let text : String? = entry?.objectForKey("summary") as AnyObject? as String?
//        let date : String? = entry?.objectForKey("issued") as AnyObject? as String?
//        let nsDate: NSDate = Utility.dateFromStringFormat("yyyy-MM-dd'T'HH:mm:ss'+09:00'", datetime: date!)
//        let time = Utility.stringFromDate("HH:mm:ss", date: nsDate)
//        let data = ["time": time, "title": title, "text": text]
//        self.contentData += data
    }
    
    func matches(searchString: String, pattern: String) -> Bool {
//        var error:NSError?
//        let regex = NSRegularExpression .regularExpressionWithPattern(pattern, options: NSRegularExpressionOptions.DotMatchesLineSeparators, error: &error)
//        
//        if (!error){
//            let matchCount = regex.numberOfMatchesInString(
//                searchString, options: NSMatchingOptions.fromMask(0),
//                range: NSMakeRange(0, countElements(searchString))
//            )
//            return matchCount > 0
//        }
        return false
    }

}