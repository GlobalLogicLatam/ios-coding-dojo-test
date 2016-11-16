//
//  ListPresenterTest.swift
//  GLClub
//
//  Created by Francisco on 11/2/16.
//  Copyright © 2016 Maxi Garcia. All rights reserved.
//

import XCTest

class ListPresenterTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPresenterWithEmptyList() {
        let presenter: ListPresenter = ListPresenter()
        let intoutput = PresenterOutputMock()
        
        presenter.output = intoutput
        presenter.presentList(ListResponse())
        XCTAssert(intoutput.displayListVerify)
    }
    
    func testPresenterWithErrorList() {
        let presenter: ListPresenter = ListPresenter()
        let intoutput = PresenterOutputMock()
        
        presenter.output = intoutput
        presenter.presentLoadListError()
        XCTAssert(intoutput.displayLoadListErrorVerify)
    }
    
    func testPresenterWithFromModel() {
        let presenter: ListPresenter = ListPresenter()
        let intoutput = PresenterOutputMock()
        
        presenter.output = intoutput
        presenter.presentListFromModel()
        XCTAssert(intoutput.displayListFromModelVerify)
    }
    
    
    func testPresenterEmptyFilterList() {
        let presenter: ListPresenter = ListPresenter()
        let intoutput = PresenterOutputMock()
        
        presenter.output = intoutput
        let model: [Item] = []
        presenter.presentFilterList(model)
        
        XCTAssert(intoutput.filterResult.count == model.count)
        XCTAssert(intoutput.displayFilterListVerify)
    }

    func testPresenterOneFilterList() {
        let presenter: ListPresenter = ListPresenter()
        let intoutput = PresenterOutputMock()
        
        presenter.output = intoutput
        var model: [Item] = []
        model.append(Item(
            title: "abcd title cuatro",
            description: "descripcion cinco",
            content: "",
            creator: "andres",
            pubDate: "4/7/2016",
            imageURL: ""))
        presenter.presentFilterList(model)
        
        XCTAssert(intoutput.filterResult.count == model.count)
        XCTAssert(intoutput.displayFilterListVerify)
    }
    
    func testPresenterTwoFilterList() {
        let presenter: ListPresenter = ListPresenter()
        let intoutput = PresenterOutputMock()
        
        presenter.output = intoutput
        var model: [Item] = []
        model.append(Item(
            title: "abcd title cuatro",
            description: "descripcion cinco",
            content: "",
            creator: "andres",
            pubDate: "4/7/2016",
            imageURL: ""))
        model.append(Item(
            title: "abcd title tres",
            description: "descripcion dos",
            content: "",
            creator: "fran",
            pubDate: "4/7/2016",
            imageURL: ""))
        presenter.presentFilterList(model)
        
        XCTAssert(intoutput.filterResult.count == model.count)
        XCTAssert(intoutput.displayFilterListVerify)
    }
    
    func testPresenterThreeFilterList() {
        let presenter: ListPresenter = ListPresenter()
        let intoutput = PresenterOutputMock()
        
        presenter.output = intoutput
        var model: [Item] = []
        model.append(Item(
            title: "abcd title cuatro",
            description: "descripcion cinco",
            content: "",
            creator: "andres",
            pubDate: "4/7/2016",
            imageURL: ""))
        model.append(Item(
            title: "abcd title tres",
            description: "descripcion dos",
            content: "",
            creator: "fran",
            pubDate: "4/7/2016",
            imageURL: ""))
        model.append(Item(
            title: "abcd title cuatro",
            description: "descripcion menos uno",
            content: "",
            creator: "Facu",
            pubDate: "6/2/2015",
            imageURL: ""))
        presenter.presentFilterList(model)
        
        XCTAssert(intoutput.filterResult.count == model.count)
        XCTAssert(intoutput.displayFilterListVerify)
    }

}

class PresenterOutputMock : ListPresenterOutput {
    var displayListVerify: Bool         = false
    var displayLoadListErrorVerify: Bool         = false
    var displayListFromModelVerify: Bool         = false
    var displayImageVerify: Bool         = false
    var displayFilterListVerify: Bool         = false
    
    var filterResult: [Item] = []
    
    var displayListCount: Int          = 0
    var displayLoadListErrorCount: Int          = 0
    var displayListFromModelCount: Int          = 0
    var displayImageCount: Int          = 0
    var displayFilterListCount: Int          = 0
    
    func displayList(_ viewModel: ListViewModel) {
        self.displayListVerify = true
        self.displayListCount += 1
    }
    
    func displayLoadListError() {
        self.displayLoadListErrorVerify = true
        self.displayLoadListErrorCount += 1
    }
    
    func displayList() {
        self.displayListFromModelVerify = true
        self.displayListFromModelCount += 1
    }

    func displayImage(_ image: UIImage, forIndexPath: IndexPath) {
        self.displayImageVerify = true
        self.displayImageCount += 1
    }
    
    func displayFilterList(_ list: [Item]) {
        self.filterResult = list
        self.displayFilterListVerify = true
        self.displayFilterListCount += 1
    }
}
