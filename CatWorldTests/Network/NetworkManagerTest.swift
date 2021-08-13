//
//  NetworkManagerTest.swift
//  CatWorldTests
//

import XCTest
@testable import CatWorld

class NetworkManagerTest: XCTestCase {

    var sut: NetworkManager?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }


    func testCatBreedSuccessResponse(){
        // When we don't provide any data to Mock session

        // GIVEN: Mock Data and we will initialize mock network session
        let mockData  = MockData.breeds
        let searchMock = "mock"
        let mockURL = URL(string: "www.mockurl.com")
        let session = MockNetworkSession(data: mockData,
                                         error: nil,
                                         url: mockURL)
        sut = NetworkManager(session:session)


        // THEN: It should fulfill expectations
        let expectation = XCTestExpectation(description: "Expected success with mock data")

        // WHEN: Call the server
        sut?.fetchCatsFromServer(search: searchMock, completion: { response in
            switch response {
            // Handle the failure
            case .failure(_):
                XCTFail("No error expected")
            // Handle success
            case .success(_):
                // THEN: We will sucess response which meet our expectations
                expectation.fulfill()
            }
        })

        wait(for: [expectation], timeout: 5)

    }

    func testImagesDataSuccessResponse(){
        // When we don't provide any data to Mock session

        // GIVEN: Mock Data and we will initialize mock network session
        let mockData  = MockData.imageData
        let mockId = "mockID"
        let mockURL = URL(string: "www.mockurl.com")
        let session = MockNetworkSession(data: mockData,
                                         error: nil,
                                         url: mockURL)
        sut = NetworkManager(session:session)


        // THEN: It should fulfill expectations
        let expectation = XCTestExpectation(description: "Expected success with mock data")

        // WHEN: Call the server
        sut?.fetchImageData(for: mockId, completion:
                { response in
            switch response {
            // Handle the failure
            case .failure(_):
                XCTFail("No error expected")
            // Handle success
            case .success(_):
                // THEN: We will sucess response which meet our expectations
                expectation.fulfill()
            }
        })

        wait(for: [expectation], timeout: 5)

    }
}

