//
//  ImageCache.swift
//  CatWorld
//

import UIKit

protocol ImageCacheProtocol: AnyObject {

    func clearCache()
    func cancelAllRequest()
    func load(item: Breed.ImageModel,
              completion: @escaping (Breed.ImageModel,
                                     UIImage?) -> Swift.Void)
}

final class ImageCache {

    typealias Image = Breed.ImageModel
    private let cachedImages = NSCache<NSURL, UIImage>()
    private var loadingResponses = [URL: [(Image, UIImage?) -> Swift.Void]]()
    

    private static func urlSession() -> NetworkSession {
        let config = URLSessionConfiguration.ephemeral
        return  URLSession(configuration: config)
    }
    static let publicCache = ImageCache()

    private init() { }

}

// Image Cache Protocol
extension ImageCache: ImageCacheProtocol {

    // Cancel all requests
    func cancelAllRequest() {

        ImageCache.urlSession().finishAllRequest()
        loadingResponses.removeAll()
    }

    // For memory warning clear cache
    func clearCache() {
        cachedImages.removeAllObjects()
    }
    /// - Tag: cache
    // Returns the cached image if available, otherwise asynchronously loads and caches it.
    func load(item: Breed.ImageModel,
              completion: @escaping (Image, UIImage?) -> Swift.Void) {

        guard let url = URL(string: item.url) else {
            completion(item, nil)
            return
        }

        // Check for a cached image.
        if let cachedImage = image(url: url as NSURL) {
            DispatchQueue.main.async {
                item.image = cachedImage
                completion(item, cachedImage)
            }
            return
        }
        // We will store all requests in array.
        if loadingResponses[url] == nil {
            loadingResponses[url] = [completion]
        }

        // Go fetch the image.
        ImageCache.urlSession().fetchData(for: url, headers: [:]) {
            (data, imageURL, error) in
            // Check for the error, then data and try to create the image.
            guard let responseData = data,
                  let image = UIImage(data: responseData),
                  let imageURL = imageURL,
                  let blocks = self.loadingResponses[imageURL], error == nil else {
                DispatchQueue.main.async {
                    completion(item, nil)
                }
                return
            }
            // Cache the image.
            self.cachedImages.setObject(image,
                                        forKey: imageURL as NSURL,
                                        cost: responseData.count)
            // Iterate over each requestor for the image and pass it back.
            for block in blocks {
                DispatchQueue.main.async {
                    block(item, image)
                }
                return
            }
        }
    }
}


private extension ImageCache {
    func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
}
