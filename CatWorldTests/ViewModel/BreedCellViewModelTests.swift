//
//  BreedCellViewModelTests.swift
//  CatWorldTests
//

import XCTest
@testable import CatWorld

class BreedCellViewModelTests: XCTestCase {

    var sut: BreedCellViewModel!

    override func tearDown() {
        sut = nil
    }

    func testBreedCellViewModel() throws {
        // GIVEN: Mock image data and breed Mock data
        let index = 1
        getBreeds { [weak self] list in
            guard let breeds = list,
                  let breed = breeds[safe: index],
                  let self = self else {
                XCTFail("Incorrect data format")
                return
            }
            self.getBreedWithimageModel(for: breed, { finalBreed in
                // THEN: Test Breed cell view model
                self.checkBreedCellViewModel(finalBreed!)
            })
        }
    }

    func checkBreedCellViewModel(_ breed: Breed) {

        // GIVEN: Mock data and initialize  view model
        guard let mockimageModel = MockData.imageModel else {
            XCTFail("Incorrect data format")
            return
        }
        let fakeImageCache = MockImageCache()
        let session = MockNetworkSession(data: mockimageModel,
                                         error: nil,
                                         url: nil)
        sut = BreedCellViewModel(breed,
                                 session: session,
                                 imageCache: fakeImageCache )

        let expectation = XCTestExpectation(description: "Placeholder or real image will be returned")
        let expectedName = "American Curl"
        
        // THEN: Image bindable will be called
        sut.showImage.bind { _ in
            XCTAssertNotNil(self.sut.image)
            expectation.fulfill()
        }
        XCTAssertEqual(expectedName, sut.name)
        
        // WHEN: Ask for image
        sut.getImage()

        wait(for: [expectation], timeout: 5)

    }
}
