//
//  DetailInteractor.swift
//  GLClub
//
//  Created by Maxi Garcia on 5/11/16.
//  Copyright (c) 2016 Maxi Garcia. All rights reserved.
//

import UIKit

protocol DetailInteractorInput {
    func loadContent(_ request: DetailRequest)
}

protocol DetailInteractorOutput {
    func presentDetail(_ response: DetailResponse)
}

class DetailInteractor: DetailInteractorInput {
    var output: DetailInteractorOutput!
    var worker: DetailWorker!
    
    // MARK: Business logic
    
    func loadContent(_ request: DetailRequest) {
        
        let response = DetailResponse(title: request.item.title, content: request.item.content)
        output.presentDetail(response)
    }
}
