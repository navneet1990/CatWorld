//
//  Result.swift
//  CatWorld
//

// Network Result enum
enum Result<T, U: Error> {
    case success(data: T)
    case failure(U)
}


