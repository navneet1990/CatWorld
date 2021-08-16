//
//  MockData.swift
//  CatWorldTests
//

import Foundation

struct MockData {
    static var breeds : Data?  {
        return getData(for: "Breeds")
    }

    static var imageModel : Data?  {
        return getData(for: "ImageModel")
    }
    
    private static func getData(for resource: String,
                                of type: String = "json") -> Data? {
        guard  let url = Bundle.main.url(forResource: resource, withExtension: type),
               let data = try? Data(contentsOf: url ) else {
            return nil
        }
        return data
    }
}
