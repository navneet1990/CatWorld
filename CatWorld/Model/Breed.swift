//
//  Breed.swift
//  Breed
//

import UIKit

class Breed: Decodable {
    let name: String
    var temperament: String?
    var wikipedia: String?
    var imageModel: ImageModel?
    var referenceId: String?
    var energyLevel: Int?
    
    private enum CodingKeys: String,
                             CodingKey {
        case name
        case temperament
        case wikipedia = "wikipedia_url"
        case referenceId = "reference_image_id"
        case energyLevel = "energy_level"
    }
}

