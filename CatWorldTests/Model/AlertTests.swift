//
//  AlertTest.swift
//  CatWorldTests
//

import XCTest
@testable import CatWorld

class AlertTests: XCTestCase {
    
    func testAlert() {
        
        // GIVEN: Alert actions initializations
        let expectAlertActionHandlerCall = expectation(description: "Alert action handler called")
        
        let alert = SingleButtonAlert(
            title: "",
            message: "",
            action: AlertAction(buttonTitle: "",
                                handler: {
                                 // THEN: Expectations matched
                                 expectAlertActionHandlerCall.fulfill()
                                })
        )
        
        // WHEN: Handler is called
        alert.action.handler!()
        
        // THEN: Expectations must be matched
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}

