//
//  NetworkManager.swift
//  CatWorld
//

import Foundation

struct NetworkManager: NetworkProtocol {
    typealias SearchResult = Result<[Breed], ErrorResult>
    typealias SearchCompletion = (_ result: SearchResult) -> Void

    typealias BreedImageResult = Result<Breed.ImageData, ErrorResult>
    typealias BreedImageCompletion = (_ result: BreedImageResult) -> Void

    private let session: NetworkSession

    // MARK:- Initialization
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    // MARK:- Network protocol methods
    func fetchCatsFromServer(search text: String,
                             completion: @escaping SearchCompletion) {
        session.finishAllRequest()

        // Validate for UI testing
        if isUITestCaseRunning(){
            guard let data = getMockData() else{
                completion(.failure(.invalidDataFormat))
                return
            }

            NetworkManager.decode(data: data, completion: completion)
            return
        }

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

    func fetchImageData(for id: String,
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
            NetworkManager.decode(imageData: data, completion: completion)
        }
    }
}

