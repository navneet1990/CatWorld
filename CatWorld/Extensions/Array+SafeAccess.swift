//
//  Array+SafeAccess.swift
//  CatWorld
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
