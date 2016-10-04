//
//  NetworkManager.swift
//  GLClub
//
//  Created by Maxi Garcia on 5/11/16.
//  Copyright © 2016 Maxi Garcia. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class NetworkManager: NSObject {
    
    var baseUrl: String!
    
    init(baseUrl: String) {
        super.init()
        self.baseUrl = baseUrl
    }
    
    fileprivate override init() {
        super.init()
    }
    
    func getString(_ path: String, success:@escaping (_ response: String) -> Void, fail: @escaping (_ error: NSError) -> Void) {
        Alamofire.request(self.baseUrl + path ) .validate()
            .responseString( encoding: String.Encoding.utf8, completionHandler: {
                afResponse in
                if afResponse.result.isSuccess {
                    success(afResponse.result.value!)
                } else {
                    fail(afResponse.result.error! as NSError)
                }
            })
    }
    
    func getImage(_ url: String, success:@escaping (_ response: UIImage) -> Void, fail:@escaping (_ error: NSError) -> Void) {
        
        Alamofire.request(url)
            .responseImage { response in
                debugPrint(response)
                if response.result.isSuccess {
                    success(response.result.value!)
                } else {
                    fail(response.result.error! as NSError)
                }
        }
    }
}
