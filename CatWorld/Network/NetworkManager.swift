//
//  NetworkManager.swift
//  CatWorld
//

import Foundation

struct NetworkManager: NetworkProtocol {
    typealias SearchResult = Result<[Breed], ErrorResult>
    typealias SearchCompletion = (_ result: SearchResult) -> Void

    typealias BreedImageResult = Result<Breed.ImageModel, ErrorResult>
    typealias BreedImageCompletion = (_ result: BreedImageResult) -> Void

    private let session: NetworkSession

    // MARK:- Initialization
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    // MARK:- Network protocol methods
    func fetchCatsFromServer(search text: String,
                             completion: @escaping SearchCompletion) {
        // Validate for UI testing
        if isUITestCaseRunning(){
          guard let data = getMockBreedsData() else{
            completion(.failure(.invalidDataFormat))
            return
          }

          NetworkManager.decode(data: data, completion: completion)
          return
        }

        session.finishAllRequest()

        // Get a URL to load, and a URLSession to load it.
        let endPoint = Endpoint.search(text)

        guard let url = endPoint.url else {
            completion(.failure(.invalidUrl))
            return
        }

        session.fetchData(for: url,
                          headers: endPoint.headers) {
            data, _, error in

            // Alert the user if no data comes back.
            guard let data = data else {
                completion(.failure(.networkUnavailable))
                return
            }

            // Decode the JSON
            NetworkManager.decode(data: data, completion: completion)
        }
    }

    func fetchimageModel(for id: String,
                        completion: @escaping BreedImageCompletion) {


        let endPoint = Endpoint.imagesData(id)

        guard let url = endPoint.url else {
            completion(.failure(.invalidUrl))
            return
        }

        session.fetchData(for: url,
                          headers: endPoint.headers) { data, _, error in
            // Alert the user if no data comes back.
            guard let data = data else {
                completion(.failure(.networkUnavailable))
                return
            }
            
            // Decode the JSON
            NetworkManager.decode(imageModel: data, completion: completion)
        }
    }
}

