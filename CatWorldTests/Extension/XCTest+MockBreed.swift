//
//  XCTest+MockBreed.swift
//  CatWorldTests
//

import XCTest
@testable import CatWorld

// MARK:- Breeds
extension XCTest {

    // All Breeds from mock data
    func getBreeds(_ completion: @escaping ([Breed]?) -> Void) {
        guard let mockBreedsData = MockData.breeds else {
            completion(nil)
            return
        }
        // WHEN: Breeds data is decoded
        NetworkManager.decode(data: mockBreedsData) {
            result in
            switch result {
            case .failure(_):
                completion(nil)
            case .success(let list):
                // THEN: Test Breed cell view model
                completion(list)
            }
        }
    }

    // Update Breed with image data
    func getBreedWithimageModel(for breed: Breed,
                               _ completion: @escaping (Breed?) -> Void) {

        guard let fakeimageModel = MockData.imageModel else {
            completion(nil)
            return
        }
        //  Image data is decoded
        NetworkManager.decode(imageModel: fakeimageModel) {
            result in
            switch result {
            case .failure(_):
                completion(nil)
            case .success(let data):
                breed.imageModel = data
                completion(breed)
            }
        }
    }
}
