//
//  UIImageView+Util
//  Dots
//
//  Created by Kouno, Masayuki on 1/7/15.
//  Copyright (c) 2015 Kouno, Masayuki. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImageAsync(urlString: String) {
        let url = NSURL(string: urlString)
        var request: NSURLRequest = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if data != nil {
                self.image = UIImage(data: data)
            } else {
                println(error)
            }
        })
    }
    
    func clipToCircle() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}