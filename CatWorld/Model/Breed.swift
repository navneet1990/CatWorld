//
//  Breed.swift
//  Breed
//

import UIKit

class Breed: Decodable {
    let name: String
    var temperament: String?
    var wikipedia: String?
    var imageData: ImageData?
    var referenceId: String?
    var energyLevel: Int?
    
    private enum CodingKeys: String,
                             CodingKey {
        case name
        case temperament
        case wikipedia = "wikipedia_url"
        case referenceID = "reference_image_id"
        case energyLevel = "energy_level"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        temperament = try container.decodeIfPresent(String.self,
                                                    forKey: .temperament)
        wikipedia = try container.decodeIfPresent(String.self,
                                                  forKey: .wikipedia)
        energyLevel = try container.decodeIfPresent(Int.self,
                                                    forKey: .energyLevel)
        referenceId = try container.decodeIfPresent(String.self,
                                                  forKey: .referenceID)
    }
}

