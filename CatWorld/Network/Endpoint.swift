//
//  Endpoint.swift
//  CatWorld
//

import Foundation

// MARK: - Endpoint
/// Reusable base Endpoint struct
struct Endpoint {
    var path: String
    var prefixHost: String
    var queryItems: [URLQueryItem] = []
}

/// Dummy API specific Endpoint extension

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = prefixHost + "thecatapi.com"
        components.path =  path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }

        return url
    }

    var headers: [String: String] {
        return [
            "x-api-key": "b0819e77-42d0-4b42-a16f-d06ef072f43c"
        ]
    }
}

extension Endpoint {

    static func search(_ text: String) -> Self {
        return Endpoint(path: "/v1/breeds/search", prefixHost: "api.", queryItems: [
            URLQueryItem(name: "q", value: text)
        ])
    }
    static func imagesData(_ id: String) -> Self {
        return Endpoint(path: "/v1/images/" + id, prefixHost: "api.")
    }

}
