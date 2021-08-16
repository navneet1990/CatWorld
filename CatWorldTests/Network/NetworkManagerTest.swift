//
//  NetworkManagerTest.swift
//  CatWorldTests
//

import XCTest
@testable import CatWorld

class NetworkManagerTest: XCTestCase {

    var sut: NetworkManager?

    override func tearDown() {
        super.tearDown()
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
        let mockData  = MockData.imageModel
        let mockId = "mockID"
        let mockURL = URL(string: "www.mockurl.com")
        let session = MockNetworkSession(data: mockData,
                                         error: nil,
                                         url: mockURL)
        sut = NetworkManager(session:session)


        // THEN: It should fulfill expectations
        let expectation = XCTestExpectation(description: "Expected success with mock data")

        // WHEN: Call the server
        sut?.fetchimageModel(for: mockId, completion:
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

