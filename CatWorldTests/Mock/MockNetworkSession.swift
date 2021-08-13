//
//  MockNetworkSession.swift
//  CatWorldTests
//

import XCTest
@testable import CatWorld

struct MockNetworkSession: NetworkSession {
    var data: Data?
    var error: Error?
    var url: URL?
    
    func fetchData(for url: URL, headers: [String : String], completionHandler: @escaping (Data?, URL?, Error?) -> Void) {
        completionHandler(data, url, error)
    }
    
    func finishAllRequest() {
    }
}
