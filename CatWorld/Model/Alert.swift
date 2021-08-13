//
//  Alert.swift
//  CatWorld
//

import Foundation

struct SingleButtonAlert {
  let title: String
  let message: String?
  let action: AlertAction
}

struct AlertAction {
  let buttonTitle: String
  let handler: (() -> Void)?
}
