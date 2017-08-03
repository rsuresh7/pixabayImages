//
//  Hit.swift
//  pixabayImages
//
//  Created by Suresh Rajalingam on 01/08/2017.
//  Copyright © 2017 Suresh Rajalingam. All rights reserved.
//

import UIKit

class Hit: NSObject {
    
    var id:Int?
    var previewURL:String?
    var userImageURL:String?
    var webformatURL:String?
    
    override init(){}
    
    init(hitData:NSDictionary) {
        if let hitID = (hitData["id"] as? Int) {
            self.id = hitID
        }
        
        if let hitPreviewURL = (hitData["previewURL"] as? String) {
            self.previewURL = hitPreviewURL
        }
        
        if let hitUserImageURL =  (hitData["userImageURL"] as? String) {
            self.userImageURL = hitUserImageURL
        }
        
        if let hitWebformatURL =  (hitData["webformatURL"] as? String) {
            self.webformatURL = hitWebformatURL
        }
        
    }
}
