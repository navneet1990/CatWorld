//
//  NetworkProtocol.swift
//  CatWorld
//

// Network Protocol
protocol NetworkProtocol {
    // TypeAlias for custom content
    typealias SearchResult = Result<[Breed], ErrorResult>
    typealias SearchCompletion = (_ result:
                                   SearchResult) -> Void
    typealias BreedImageResult = Result<Breed.ImageData,
                                        ErrorResult>
    typealias BreedImageCompletion = (_ result:
                                       BreedImageResult) -> Void


    /// Method to fetch data server
    ///
    /// - Parameters:
    ///   - text: Query string to search with server
    ///   - completion: Response in form of JSON if successfull otherwise error
    func fetchCatsFromServer(search text: String,
                             completion: @escaping SearchCompletion)

    /// Method to fetch Image
    ///
    /// - Parameters:
    ///   - urlString: Url to interact with server
    ///   - completion: Response in form of JSON if successfull otherwise error

    func fetchImageData(for id: String,
                        completion: @escaping BreedImageCompletion)
}
