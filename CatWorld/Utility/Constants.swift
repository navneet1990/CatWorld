//
//  Constants.swift
//  CatWorld
//

import UIKit

struct Constants {
    
    // Mock Data constants
    struct Mock {
        static var data : Data?  {
            guard  let url = Bundle.main.url(forResource: "mock", withExtension: "json"),let data = try? Data(contentsOf: url ) else {
                return nil
            }
            return data
        }
        static let image = UIImage.init(named: "mockUserImage")
    }

}

