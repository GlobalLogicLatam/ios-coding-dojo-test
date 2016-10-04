//
//  DetailPresenter.swift
//  GLClub
//
//  Created by Maxi Garcia on 5/11/16.
//  Copyright (c) 2016 Maxi Garcia. All rights reserved.
//

import UIKit

protocol DetailPresenterInput {
    func presentDetail(_ response: DetailResponse)
}

protocol DetailPresenterOutput: class {
    func displayDetail(_ viewModel: DetailViewModel)
}

class DetailPresenter: DetailPresenterInput {
    weak var output: DetailPresenterOutput!
    
    // MARK: Presentation logic
    
    func presentDetail(_ response: DetailResponse) {
        
        let viewModel = DetailViewModel(title: response.title, content: response.content)
        output.displayDetail(viewModel)
    }
}
