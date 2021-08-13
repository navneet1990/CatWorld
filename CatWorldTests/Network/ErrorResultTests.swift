//
//  ErrorResultTests.swift
//  CatWorldTests
//

import XCTest
@testable import CatWorld

class ErrorResultTests: XCTestCase {

    var sut: ErrorResult!

    func testNetworkConnectionSuccessfully(){

        // GIVEN: Initialize by network unavailable
        sut = .networkUnavailable

        // THEN: Should match the title and description
        let expectedDescription = "Check your network connection"
        let expectedTitle = "Network"

        XCTAssertEqual(expectedDescription,sut.description)
        XCTAssertEqual(expectedTitle, sut.title)

        }

    func testInvalidUrlSuccessfully(){
        // GIVEN: Initialize by invalid url
        sut = .invalidUrl

        // THEN: Should match the title and description
        let expectedDescription = "Could not create a URL"
        let expectedTitle = "Invalid Url"

        XCTAssertEqual(expectedDescription,sut.description)
        XCTAssertEqual(expectedTitle, sut.title)
    }
    func testInvalidResponseSuccessfully() {
        // GIVEN: Initialize by invalid url
        sut = .invalidDataFormat

        // THEN: Should match the title and description
        let expectedDescription = "Could not digest the fetched data"
        let expectedTitle = "Invalid Data"
        XCTAssertEqual(expectedDescription,sut.description)
        XCTAssertEqual(expectedTitle, sut.title)
    }
}
