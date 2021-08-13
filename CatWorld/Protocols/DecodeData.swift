//
//  DecodeData.swift
//  CatWorld
//

import Foundation

protocol DecodeData {

    /// Decode the data to Breed Object
    ///
    /// - Parameters:
    ///   - data: Data to be decoded
    ///   - completion:  Response in form of Breed if successfull otherwise error
    static func decode(data: Data,
                       completion: @escaping (_ result: Result<[Breed], ErrorResult>) -> Void)

    /// Decode the data to Breed image Object
    ///
    /// - Parameters:
    ///   - data: Data to be decoded
    ///   - completion:  Response in form of Image data if successfull otherwise error
    static func decode(imageData: Data,
                       completion: @escaping (_ result: Result<Breed.ImageData, ErrorResult>) -> Void)
}

extension  NetworkManager: DecodeData {
    static func decode(imageData: Data, completion: @escaping (Result<Breed.ImageData, ErrorResult>) -> Void) {
        // Decode the JSON
        do {
            // Decode the JSON into codable type ImageData.
            let decoder = JSONDecoder()
            let responseJson = try decoder.decode(Breed.ImageData.self, from: imageData)
            completion(.success(data: responseJson))
        }
        catch{
          completion(.failure(.invalidDataFormat))
        }
    }
    static func decode(data: Data,
                       completion: @escaping (_ result: Result<[Breed],ErrorResult>) -> Void){
        // Decode the JSON
        do {
            // Decode the JSON into codable type Breeds Array.
            let decoder = JSONDecoder()
            let responseJson = try decoder.decode([Breed].self, from: data)
            completion(.success(data: responseJson))
        }
        catch{
          completion(.failure(.invalidDataFormat))
        }
    }
}

