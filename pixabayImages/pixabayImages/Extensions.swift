//
//  Extensions.swift
//  pixabayImages
//
//  Created by Suresh Rajalingam on 01/08/2017.
//  Copyright © 2017 Suresh Rajalingam. All rights reserved.
//

import UIKit


extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIViewContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async() {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}

