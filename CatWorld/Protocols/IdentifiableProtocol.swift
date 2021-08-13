//
//  IdentifiableProtocol.swift
//  CatWorld
//

import UIKit

protocol Identifiable {
  static var identifier: String { get }
}

extension Identifiable {
  static var identifier: String {
    return String(describing: self)
  }
}
extension UIViewController: Identifiable {}
