//
//  ListWorker.swift
//  GLClub
//
//  Created by Maxi Garcia on 5/10/16.
//  Copyright (c) 2016 Maxi Garcia. All rights reserved.
//

import Alamofire

protocol ListWorkerProtocol {
    func getList(_ success: @escaping (ListResponse) -> Void, fail: @escaping () -> Void)
    func getImage(_ url: String, success: @escaping (UIImage) -> Void, fail: @escaping (NSError) -> Void)
}

class ListWorker: ListWorkerProtocol {
    var networkManager = NetworkManager(baseUrl: "http://private-a972b3-myfirstapp2.apiary-mock.com")
    internal func getList(_ success: @escaping (ListResponse) -> Void, fail: @escaping () -> Void) {
        self.networkManager.getString("/feed",
                                      success: {
                                        response in
                                        success(ListResponse(fromXml: response))
            }, fail: {
                error in
                fail()
        })

    }

    internal func getImage(_ url: String, success: @escaping (UIImage) -> Void, fail: @escaping (NSError) -> Void) {
        self.networkManager.getImage(url, success: {
            image in
            success(image)
            }, fail: fail)
    }

    
    
}
