//
//  RequestManager.swift
//  pixabayImages
//
//  Created by Suresh Rajalingam on 01/08/2017.
//  Copyright © 2017 Suresh Rajalingam. All rights reserved.
//

import UIKit

import UIKit

protocol RequestManagerDelegate: class {
    
    func requestManager(receivedData:Data) -> Void
    func requestManager(receivedError:Error) -> Void
    func requestManager(receivedResponse:URLResponse) -> Void
}

class RequestManager: NSObject {
    
    var delegate : RequestManagerDelegate?
    private var apiURL : String = "https://pixabay.com/api/"
    private var apiKey : String = "5511001-7691b591d9508e60ec89b63c4"
    
    private func makeRequestWithURL(url:String) -> Void {
        guard let requestURL = URL(string: url) else {return}
        
    
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let serverResponse = response, let managerDelegate = self.delegate {
                managerDelegate.requestManager(receivedResponse: serverResponse)
            }
            
            if error == nil, let usableData = data, let managerDelegate = self.delegate {
                managerDelegate.requestManager(receivedData: usableData)
            }
            else if error != nil, let receivedError = error, let managerDelegate = self.delegate {
                managerDelegate.requestManager(receivedError: receivedError)
            }
            
        }
        
        task.resume()
    }
    
    func searchForElements(elements:String) -> Void {
        
        var research = "q=" + elements
        research = research.replacingOccurrences(of: " ", with: "+")
        research = research + "&image_type=photo"
        
        let query = apiURL + "?key=" + apiKey + "&" + research
        
        self.makeRequestWithURL(url: query)
    
    }
    
}
