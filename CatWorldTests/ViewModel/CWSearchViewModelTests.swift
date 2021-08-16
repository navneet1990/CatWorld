//
//  CWSearchViewModelTests.swift
//  CatWorldTests
//

import XCTest
@testable import CatWorld

class CWSearchViewModelTests: XCTestCase {
    var sut: CWSearchViewModel!
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testSearchCats() {
        // GIVEN: Initialization of view model with mock data and mock session
        let mockData  = MockData.breeds
        let url = URL(string: "https://api.thecatapi.com/v1/breeds/search?q=american")
        
        let session = MockNetworkSession(data: mockData,
                                         error: nil,
                                         url: url)
        sut = CWSearchViewModel(session)
        
        // THEN: Then is defined before, because binding variables must be declared before call
        let expectedBreedsCount = 4
        let expectedNames = ["American Bobtail",
                             "American Curl",
                             "American Shorthair",
                             "American Wirehair"]
        let expectationReload = XCTestExpectation(description: "Expected success with mock data")
        let expectationSearchBarTrue = XCTestExpectation(description: "Expected loading of activity indicator")
        
        
        // GIVEN: Search term and ViewModel objects
        let searchTerm = "america"
        
        sut.reloadData.bind { [unowned self] _ in
            // THEN: Expectations met
            XCTAssertEqual(expectedBreedsCount,
                           self.sut.totalItems)
            XCTAssertEqual(expectedNames,
                           self.sut.breedsViewModel.map { $0.name } )
            expectationReload.fulfill()
        }
        
        sut.searchBarLoading.bind { show in
            // THEN: Expectations met activity indicator  starts
            XCTAssertTrue(show)
            expectationSearchBarTrue.fulfill()
        }
        
        // WHEN: Search for cat breeds is called
        sut.searchCats(for: searchTerm)
        
        
        // THEN: Must meet the expectations
        wait(for: [expectationReload,
                   expectationSearchBarTrue],
             timeout: 1)
    }
    
    func testFailedSearchCats() {
        
        // GIVEN: Initialization of view model and mock session with incorrrect mock data
        let mockData  = MockData.imageModel
        let searchTerm = "america"
        let url = URL(string: "https://api.thecatapi.com/v1/breeds/search?q=amer")
        
        let session = MockNetworkSession(data: mockData,
                                         error: nil,
                                         url: url)
        sut = CWSearchViewModel(session)
        
        // THEN: Then is defined before, because binding variables must be declared before call
        let expectationSearchBarTrue = XCTestExpectation(description: "Expected loading of activity indicator")
        let expectationSearchBarFalse = XCTestExpectation(description: "Expected stopping of activity indicator")
        let expectedBackgroundMessage = "Sorry, something went wrong"
        
        // GIVEN:  ViewModel objects call
        sut.backgroundMessage.bind { (show, msg) in
            XCTAssertTrue(show)
            XCTAssertEqual(expectedBackgroundMessage,
                           msg)
        }
        sut.searchBarLoading.bind { show in
            // THEN: Expectations met activity indicator  stops
            if show {
                expectationSearchBarTrue.fulfill()
            } else {
                expectationSearchBarFalse.fulfill()
            }
        }
        
        // WHEN: Search for america cat breed with failed data response
        sut.searchCats(for: searchTerm)
        
        
        // THEN: Must meet the expectations
        wait(for: [expectationSearchBarTrue, expectationSearchBarFalse],
             timeout: 1)
    }
    
    func testShowDetails() {
        
        // GIVEN: Initialization of view model with mock data and mock session
        guard let mockData  = MockData.breeds else { return }
        
        let url = URL(string: "https://api.thecatapi.com/v1/breeds/search?q=american")
        
        let session = MockNetworkSession(data: mockData,
                                         error: nil,
                                         url: url)
        let searchTerm = "america"
        sut = CWSearchViewModel(session)
        
        
        // THEN: Expectations must be met
        let expectation = XCTestExpectation(description: "Expected show details page")
        let expectedName = "American Curl"
        let expectedTemperament = "Affectionate, Curious, Intelligent, Interactive, Lively, Playful, Social"
        let expectedEnergy = "3"
        
        sut.showDetails.bind { [unowned self] _ in
            // THEN: Must match the details
            if let details = self.sut.detailsViewModel,
               let temperant = details.temperant,
               let level = details.energy {
                XCTAssertEqual(expectedName, details.name)
                XCTAssertEqual(expectedTemperament, temperant)
                XCTAssertEqual(expectedEnergy, level)
                expectation.fulfill()
            }
        }
        
        // WHEN: Search for america
        sut.reloadData.bind { [unowned self] _ in
            self.sut.didSelectItem(at: IndexPath(row: 1,
                                                       section: 0))
        }
        sut.searchCats(for: searchTerm)
        
        wait(for: [expectation],
             timeout: 1)
    }
}
