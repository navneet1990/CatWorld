//
//  MockData.swift
//  CatWorldTests
//
//  Created by Navneet Singh on 8/12/21.
//

import Foundation

struct MockData {
    static var breeds : Data?  {
      guard  let url = Bundle.main.url(forResource: "Breeds", withExtension: "json"),
             let data = try? Data(contentsOf: url ) else {
        return nil
      }
      return data
    }

    static var imageData : Data?  {
      guard  let url = Bundle.main.url(forResource: "ImageData", withExtension: "json"),
             let data = try? Data(contentsOf: url ) else {
        return nil
      }
      return data
    }
}
