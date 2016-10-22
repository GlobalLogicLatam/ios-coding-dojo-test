//
//  ListInteractorTEST.swift
//  GLClub
//
//  Created by Maxi Garcia on 6/9/16.
//  Copyright © 2016 Maxi Garcia. All rights reserved.
//

import XCTest

class ListInteractorTest: XCTestCase {
    
    var worker: InteractorWorker!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        worker = InteractorWorker()
        worker.items.append(Item(
            title: "abcd title cuatro",
            description: "descripcion cinco",
            content: "",
            creator: "andres",
            pubDate: "4/7/2016",
            imageURL: ""))
        worker.items.append(Item(
            title: "abcd title cinco",
            description: "descripcion cinco",
            content: "",
            creator: "luis",
            pubDate: "5/7/2016",
            imageURL: ""))
        worker.items.append(Item(
            title: "dsaf title seis",
            description: "descripcion seis",
            content: "",
            creator: "luis",
            pubDate: "6/7/2016",
            imageURL: ""))
        worker.items.append(Item(
            title: "dsaf title siete",
            description: "descripcion siete",
            content: "",
            creator: "pedro",
            pubDate: "7/6/2016",
            imageURL: ""))
        worker.items.append(Item(
            title: "dsaf title ocho",
            description: "descripcion ocho",
            content: "",
            creator: "tony",
            pubDate: "8/8/2016",
            imageURL: ""))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testInteractorWithEmptyList() {
        
        let interactor: ListInteractor = ListInteractor()
        let intoutput = InteractorOutputMock()
      
        interactor.output = intoutput
        worker.callSuccess = true
        interactor.worker = worker
        interactor.loadList(ListRequest())
        XCTAssert(intoutput.presentListVerify)
    }
    
    func testInteractorWithErrorList() {
        
        let interactor: ListInteractor = ListInteractor()
        let intoutput = InteractorOutputMock()
        interactor.output = intoutput
        worker.callSuccess = false
        interactor.worker = worker
        interactor.loadList(ListRequest())
        XCTAssert(intoutput.presentLoadListErrorVerify)
    }
    
    func testInteractorWithFullList() {
        
        let interactor: ListInteractor = ListInteractor()
        let intoutput = InteractorOutputMock()
       
        interactor.output = intoutput
        worker.callSuccess = true
        interactor.worker = worker

        interactor.loadList(ListRequest())
        XCTAssert(intoutput.presentListVerify)
    }
    
    func testSearchWithEmptyTextList() {
        
        let interactor: ListInteractor = ListInteractor()
        let intoutput = InteractorOutputMock()
        
        interactor.output = intoutput
        worker.callSuccess = true
        interactor.worker = worker

        let model: ListViewModel = ListViewModel(items: worker.items)
        interactor.filterList(model, searhText: "")
        XCTAssert(intoutput.filterResult.isEmpty)
        XCTAssert(intoutput.presentListFromModelVerify)
    }
    
    func testSearchWithShortTextList() {
        
        let interactor: ListInteractor = ListInteractor()
        let intoutput = InteractorOutputMock()
        interactor.output = intoutput
        worker.callSuccess = true
        interactor.worker = worker
        let model = ListViewModel(items: worker.items)
        interactor.filterList(model, searhText: "ab")

        XCTAssert(intoutput.filterResult.isEmpty)
        XCTAssert(intoutput.presentListFromModelVerify)
    }
    
    func testSearchWithOneResultList() {
        
        let interactor = ListInteractor()
        let intoutput = InteractorOutputMock()
        
        interactor.output = intoutput
        worker.callSuccess = true
        interactor.worker = worker
        let model = ListViewModel(items: worker.items)
        interactor.filterList(model, searhText: "cua")
        
        XCTAssert(intoutput.filterResult.count == 1)
        XCTAssert(intoutput.presentFilterListVerify)
    }
    
    func testSearchWithTwoResultList() {
        
        let interactor = ListInteractor()
        let intoutput = InteractorOutputMock()
        
        interactor.output = intoutput
        worker.callSuccess = true
        interactor.worker = worker
        let model = ListViewModel(items: worker.items)
        interactor.filterList(model, searhText: "abcd")
        
        XCTAssert(intoutput.filterResult.count == 2)
        XCTAssert(intoutput.presentFilterListVerify)
    }
    
    func testSearchWithoutResultList() {
        
        let interactor = ListInteractor()
        let intoutput = InteractorOutputMock()
        
        interactor.output = intoutput
        worker.callSuccess = true
        interactor.worker = worker
        let model = ListViewModel(items: worker.items)
        interactor.filterList(model, searhText: "arw")
        
        XCTAssert(intoutput.filterResult.isEmpty)
        XCTAssert(intoutput.presentFilterListVerify)
    }

    func testSearchWithTreeWhiteSpaceResultList() {
        
        let interactor = ListInteractor()
        let intoutput = InteractorOutputMock()
        
        interactor.output = intoutput
        worker.callSuccess = true
        interactor.worker = worker
        
        let model = ListViewModel(items: worker.items)
        interactor.filterList(model, searhText: "   ")

        XCTAssert(intoutput.filterResult.isEmpty)
        XCTAssert(intoutput.presentListFromModelVerify)
    }
    
    func testSearchWithLeadingSpacesAndOneResult() {
        
        let interactor = ListInteractor()
        let intoutput = InteractorOutputMock()
        
        interactor.output = intoutput
        worker.callSuccess = true
        interactor.worker = worker
        let model = ListViewModel(items: worker.items)
        interactor.filterList(model, searhText: "   cuatro")

        XCTAssert(intoutput.filterResult.count == 1)
        XCTAssert(intoutput.presentFilterListVerify)
    }
    
    func testSearchWithLeadingSpacesAndTwoResult() {
        
        let interactor = ListInteractor()
        let intoutput = InteractorOutputMock()
        
        interactor.output = intoutput
        worker.callSuccess = true
        interactor.worker = worker
        
        let model = ListViewModel(items: worker.items)
        interactor.filterList(model, searhText: "   abc")
        
        XCTAssert(intoutput.filterResult.count == 2)
        XCTAssert(intoutput.presentFilterListVerify)
    }

    func testSearchWithEndingSpacesAndOneResult() {
        
        let interactor = ListInteractor()
        let intoutput = InteractorOutputMock()
        
        interactor.output = intoutput
        worker.callSuccess = true
        interactor.worker = worker
        let model = ListViewModel(items: worker.items)
        interactor.filterList(model, searhText: "cuatro   ")
        
        XCTAssert(intoutput.filterResult.count == 1)
        XCTAssert(intoutput.presentFilterListVerify)
    }
    
    func testSearchWithLeadingAndEndingSpacesAndOneResult() {
        
        let interactor = ListInteractor()
        let intoutput = InteractorOutputMock()
        
        interactor.output = intoutput
        worker.callSuccess = true
        interactor.worker = worker
        let model = ListViewModel(items: worker.items)
        
        interactor.filterList(model, searhText: "   cuatro   ")
        
        XCTAssert(intoutput.filterResult.count == 1)
        XCTAssert(intoutput.presentFilterListVerify)
    }
}

class InteractorWorker: ListWorkerProtocol {
    
    var callSuccess: Bool = false
    var items: [Item] = []
    
    func getList(_ success: @escaping (ListResponse) -> Void, fail: @escaping () -> Void) {
        if callSuccess {
            success(ListResponse(withItems: items))
        } else {
            fail()
        }
    }
    
    func getImage(_ url: String, success: @escaping (UIImage) -> Void, fail: @escaping (NSError) -> Void) {
    
    }

}

class InteractorOutputMock: ListInteractorOutput {

    
    var presentListVerify: Bool         = false
    var presentLoadListErrorVerify: Bool = false
    var presentFilterListVerify: Bool   = false
    var presentListFromModelVerify: Bool = false
    var presentImageVerify: Bool = false

    var filterResult: [Item] = []
    
    
    var presentListCount: Int          = 0
    var presentLoadListErrorCount: Int = 0
    var presentFilterListCount: Int    = 0
    var presentListFromModelCount: Int = 0
    var presentImageCount: Int = 0

    func presentList(_ response: ListResponse) {
        self.presentListVerify = true
        self.presentListCount += 1
    }
    
    func presentLoadListError() {
        self.presentLoadListErrorVerify = true
        self.presentLoadListErrorCount += 1
        
    }
    
    func presentFilterList(_ list: [Item]) {
        
        self.filterResult = list
        self.presentFilterListVerify = true
        self.presentFilterListCount += 1
    }
    
    func presentListFromModel() {
        self.presentListFromModelVerify = true
        self.presentListFromModelCount += 1
    }
    
    func presentImage(_ image: UIImage, forIndexPath: IndexPath) {
        self.presentImageVerify = true
        self.presentImageCount += 1
    }
}
