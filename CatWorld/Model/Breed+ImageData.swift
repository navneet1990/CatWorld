//
//  Breed+ImageData.swift
//  CatWorld
//

import UIKit

extension Breed {

    class ImageData: Decodable {
        let url: String
        let id: String
        var image: UIImage?

        private enum CodingKeys: String,
                                 CodingKey {
            case url
            case id
        }

        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            id = try container.decode(String.self,
                                      forKey: .id)
            url = try container.decode(String.self,
                                       forKey: .url)

        }
    }
}

