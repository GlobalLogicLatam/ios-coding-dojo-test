//
//  GLCLubDetailModels.swift
//  GLClub
//
//  Created by Maxi Garcia on 5/11/16.
//  Copyright (c) 2016 Maxi Garcia. All rights reserved.
//

struct DetailRequest {
    var item: Item
}

struct DetailResponse {
    var title: String
    var content: String
}

struct DetailViewModel {
    var title: String
    var content: String
}
