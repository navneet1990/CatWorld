//
//  ErrorResult.swift
//  CatWorld
//

import Foundation

// Error enum
enum ErrorResult: Error {
    case invalidUrl
    case networkUnavailable
    case invalidDataFormat
    case unknown
}

extension ErrorResult: LocalizedError {
    public var description: String? {
        switch self {
        case .invalidUrl:
            return NSLocalizedString("Could not create a URL", comment: "")
        case .networkUnavailable:
            return NSLocalizedString("Check your network connection", comment: "")
        case .invalidDataFormat:
            return NSLocalizedString("Could not digest the fetched data", comment: "")
        default:
            return NSLocalizedString("Unknown error occured", comment: "")
        }
    }
    public var title: String? {
        switch self {
        case .invalidUrl:
            return NSLocalizedString("Invalid Url", comment: "")
        case .networkUnavailable:
            return NSLocalizedString("Network", comment: "")
        case .invalidDataFormat:
            return NSLocalizedString("Invalid Data", comment: "")
        default:
            return NSLocalizedString("", comment: "")
        }
    }
    
    public var backgroundMessage: String? {
        return NSLocalizedString("Sorry, something went wrong", comment: "")
    }
}
