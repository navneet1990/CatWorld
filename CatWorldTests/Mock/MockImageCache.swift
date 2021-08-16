//
//  MockImageCache.swift
//  CatWorldTests
//

import UIKit
@testable import CatWorld

class MockImageCache: ImageCacheProtocol {
    var fakeImage: UIImage = UIImage()
    
    var didClearCache = false
    func clearCache() {
        didClearCache = true
    }
    
    var didCancelAllRequest = false
    func cancelAllRequest() {
        didCancelAllRequest = true
    }
    
    func load(item: Breed.ImageModel, completion: @escaping (Breed.ImageModel, UIImage?) -> Void) {
        completion(item,fakeImage)
    }
    
    
}
