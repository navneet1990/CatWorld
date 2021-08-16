//
//  BindableTests.swift
//  CatWorldTests
//

import XCTest
@testable import CatWorld

class BindableTests: XCTestCase {

    func testBind() {

        // GIVEN: Bindable bool object
        let bindable = Bindable(false)
        let expectListenerCalled = expectation(description: "Listener is called")

        // THEN: Binding will be performed once, value is added or updated on bindable listerner
        bindable.bind { value in
            XCTAssertTrue(value == true)
            expectListenerCalled.fulfill()
        }

        // WHEN: Value is updated or assigned to bindable object
        bindable.value = true

        // THEN: Expectations must be fulfilled before timeout
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testBindAndFire() {
        
        // GIVEN: Bindable bool object
        let bindable = Bindable(false)
        let expectListenerCalled = expectation(description: "Listener is called")

        // WHEN: Here default assigned value is used, which is helpful for setting default values
        bindable.bindAndFire { value in
            // THEN: Expectations will be met
            XCTAssertFalse(value)
            expectListenerCalled.fulfill()
        }

        // THEN: Expectations must be fulfilled before timeout
        waitForExpectations(timeout: 0.1, handler: nil)
    }

}
