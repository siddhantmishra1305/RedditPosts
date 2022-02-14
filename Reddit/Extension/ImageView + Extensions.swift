//
//  ImageView + Extensions.swift
//  Reddit
//
//  Created by Siddhant Mishra on 13/02/22.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    //This function downloads the image and caches it for future use.
    func imageFromServerURL( urlString: String , placeHolder: UIImage?, handler:@escaping (Bool)->Void) {
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
            handler(true)
            return
        }
        
        if urlString.count == 0 {
            self.image = placeHolder
            handler(false)
            return
        }
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                            self.image = downloadedImage
                            handler(true)
                        }
                    }
                }
            }).resume()
        }
    }
}

extension Date {
    // This function converts a date to string as specified in format
    func toString(format: String) -> String? {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }
    
    func toMilliseconds() -> Int64 {
        Int64(self.timeIntervalSince1970 * 1000)
    }
}

