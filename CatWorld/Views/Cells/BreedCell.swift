//
//  BreedCell.swift
//  CatWorld
//

import UIKit

class BreedCell: UICollectionViewCell {

    // MARK:- Variable
    var viewModel: BreedCellViewModel? = nil {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            activityIndicator.startAnimating()

            name.text = viewModel.name

            if let image = viewModel.image {
                setImage(image)
            } else {
                // Using binding to fetch image from server
                viewModel.showImage.bind { [weak self] _ in
                    guard
                        let image = viewModel.image else { return }
                    self?.setImage(image)

                }
                viewModel.getImage()
            }
        }
    }

    private func setImage(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = image
            self?.activityIndicator.stopAnimating()
        }
    }

    // MARK:- IBOutlets
    @IBOutlet weak var imageView: UIImageView! 
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        imageView.image = nil
        name.text = nil
        activityIndicator.stopAnimating()
        viewModel?.unbind()
        super.prepareForReuse()
    }
}
