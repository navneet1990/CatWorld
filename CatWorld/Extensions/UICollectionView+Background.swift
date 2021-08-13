//
//  UICollectionView+Background.swift
//  CatWorld
//
import UIKit

extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let width = bounds.size.width
        let height = bounds.size.height
        let msgLabel = UILabel(frame: CGRect(x: 0,
                                             y: 0,
                                             width: width,
                                             height: height))
        msgLabel.text = message
        msgLabel.textColor = .darkGray
        msgLabel.numberOfLines = 0;
        msgLabel.textAlignment = .center;
        msgLabel.font = UIFont(name: "TrebuchetMS",
                               size: 20)
        msgLabel.sizeToFit()

        backgroundView = msgLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
