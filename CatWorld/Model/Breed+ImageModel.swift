//
//  Breed+ImageModel.swift
//  CatWorld
//

import UIKit

extension Breed {
    
    class ImageModel: Decodable {
        let url: String
        let id: String
        var image: UIImage?
        
        private enum CodingKeys: String,
                                 CodingKey {
            case url
            case id
        }
    }
}

