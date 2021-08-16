//
//  CatWorldUITests.swift
//  CatWorldUITests
//

import XCTest

class CatWorldUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
      continueAfterFailure = false
      app = XCUIApplication()
      app.launchArguments.append("isUITesting")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchBar() throws {
        // UI tests must launch the application that they test.
        app.launch()

        let searchBreedByNameSearchField = app.searchFields["search breed by name"]
        XCTAssertTrue(searchBreedByNameSearchField.exists)

        searchBreedByNameSearchField.tap()
        searchBreedByNameSearchField.typeText("America")



        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

    }
}
