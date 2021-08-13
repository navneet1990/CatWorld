//
//  UIViewController+Segue.swift
//  CatWorld
//

import UIKit

extension UIViewController {
    func performSegue<T: UIViewController>(_:T.Type, sender: Any? = nil) {
        performSegue(withIdentifier: T.identifier,
                     sender: sender)
    }

    func presentAlert(_ alertObject: SingleButtonAlert) {
        let alert = UIAlertController(title: alertObject.title, message: alertObject.message, preferredStyle: .alert)

        let action = UIAlertAction.init(title: alertObject.action.buttonTitle, style: .default, handler: nil)

        alert.addAction(action)

        DispatchQueue.main.async { [weak self] in
            self?.present(alert,
                          animated: true,
                          completion: nil)
        }
    }
}
