//
//  CWDetailViewController.swift
//  CatWorld
//

import UIKit

class CWDetailViewController: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var temperantLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var wikiButton: UIButton!
    @IBOutlet weak var energyLevel: UILabel!
    
    // MARK:- Properties
    var viewModel: CWDetailViewModel?
    
    // MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        unbindViewModel()
    }
    
    @IBAction func wikiButtionAction(_ sender: Any) {
        viewModel?.openWikipedia()
    }
}

// MARK:- Private methods
private extension CWDetailViewController {
    
    func unbindViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.displayDetails.bind { _ in
            DispatchQueue.main.async { [weak self] in
                self?.nameLabel.text = viewModel.name
                self?.temperantLabel.text = viewModel.temperant
                self?.energyLevel.text = viewModel.energy
                self?.wikiButton.isHidden = viewModel.hideWikipedia
            }
        }
        
        viewModel.redirectToSafari.bind { url in
            guard let url = url else { return }
            DispatchQueue.main.async {
                UIApplication.shared.open(url)
            }
        }
        
        viewModel.loadImage.bind { _ in
            DispatchQueue.main.async { [weak self] in
                if let image = viewModel.image {
                    self?.imageView.image = image
                }
            }
        }
        viewModel.loadDetails()
    }
}
