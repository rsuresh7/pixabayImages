//
//  Parser.swift
//  pixabayImages
//
//  Created by Suresh Rajalingam on 01/08/2017.
//  Copyright © 2017 Suresh Rajalingam. All rights reserved.
//

import UIKit

class DataParser: NSObject {

    func parseJSON(data:Data) -> NSDictionary? {
        do {
            let parsed = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            return(parsed)
        }
            
        catch let error {
            print("JSON parsing error:\(error)")
        }
            return nil
    }

}
