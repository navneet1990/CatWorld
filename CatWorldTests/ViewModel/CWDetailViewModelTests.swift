//
//  CWDetailViewModelTests.swift
//  CatWorldTests
//

import XCTest
@testable import CatWorld

class CWDetailsViewModelTests: XCTestCase {

    var sut: CWDetailViewModel!

    override func tearDown()  {
        super.tearDown()
        sut = nil
    }

    func testViewModel() throws {
        // THEN: Expectations must be met
        let expectation1 = XCTestExpectation(description: "Expected details")
        let expectation2 = XCTestExpectation(description:"Reload Image")
        let expectation3 = XCTestExpectation(description: "Open Safari")

        // GIVEN: Mock data and initialize  view model
        getBreeds { [weak self] list in
            guard let breeds = list,
                  let breed = breeds.first,
                  let self = self else {
                XCTFail()
                return
            }
            self.getBreedWithimageModel(for: breed, { finalBreed in

                // GIVEN: Details View Model
                let fakeImageCache = MockImageCache()
                self.sut = CWDetailViewModel(breed: breed,
                                             imageCache: fakeImageCache)


                // WHEN: Binders are called
                self.sut.displayDetails.bind({ _ in
                    XCTAssertNil(self.sut.image)
                    expectation1.fulfill()
                })
                self.sut.loadImage.bind({ _ in
                    XCTAssertNotNil(self.sut.image)
                    expectation2.fulfill()

                    // WHEN: Asked for open Wikipidia
                    self.sut.openWikipedia()
                })
                self.sut.redirectToSafari.bind({ _ in
                    expectation3.fulfill()
                })

                // THEN: Validate View Model
                let expectedLevel = "3"
                XCTAssertNotNil(self.sut)
                XCTAssertFalse(self.sut.hideWikipedia)
                XCTAssertEqual(expectedLevel,
                               self.sut.energy)


                // WHEN: Call will be made for data
                self.sut.loadDetails()
            })
        }

        // THE: Expectations must be met
        wait(for: [expectation1,
                   expectation2,
                   expectation3],
             timeout: 10)
    }
}
