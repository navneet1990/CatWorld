//
//  NetworkSessionProtocol.swift
//  CatWorld
//

import Foundation

protocol NetworkSession {

    /// Url Session to send request to server
    ///
    /// - Parameters:
    ///   - url: Url pass to interact with server
    ///   - completionHandler:  Response in form of Dat if successfull otherwise error
    func fetchData(for url: URL,
                   headers: [String: String],
                   completionHandler: @escaping (Data?, URL? ,Error?) -> Void)

    /// Finish and invalidate all the requests
    func finishAllRequest()
}

extension URLSession: NetworkSession {
    func fetchData(for url: URL,
                   headers: [String: String],
                   completionHandler: @escaping (Data?,
                                                 URL?,
                                                 Error?)
                    -> Void) {

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        let task = dataTask(with: request) { (data, response, error) in
            completionHandler(data, response?.url, error)
        }
        task.resume()
    }
    
    func finishAllRequest() {
        finishTasksAndInvalidate()
    }
}
