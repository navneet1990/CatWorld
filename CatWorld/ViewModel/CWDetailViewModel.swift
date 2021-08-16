//
//  CWDetailViewModel.swift
//  CatWorld
//

import UIKit

final class CWDetailViewModel: DetailsViewModelProtocol {

    //MARK:- Properties
    private let wikipedia: URL?
    private let imageCache: ImageCacheProtocol
    private var imageModel: Breed.ImageModel?
    
    let name: String
    let hideWikipedia: Bool
    let temperant: String?
    let energy: String?

    var image: UIImage? {
        didSet {
            loadImage.value = ()
        }
    }

    var displayDetails: Bindable<Void> = Bindable(())
    var loadImage: Bindable<Void> = Bindable(())
    var redirectToSafari: Bindable<URL?> = Bindable(nil)

    // MARK:- Intialization
    init(breed: Breed,
         imageCache: ImageCacheProtocol = ImageCache.publicCache) {
        self.imageCache = imageCache
        self.name = breed.name
        self.wikipedia = URL(string: breed.wikipedia ?? "")
        if let energy = breed.energyLevel {
            self.energy = String(describing: energy)
        } else {
            energy = nil
        }
        self.temperant = breed.temperament
        self.hideWikipedia = breed.wikipedia == nil
        self.imageModel = breed.imageModel
    }
    
    // MARK:- Public methods
    func loadDetails() {
        displayDetails.value = ()
        getImage()
    }
    func openWikipedia() {
        redirectToSafari.value = wikipedia
    }
    
    private func getImage() {
        if let imageModel = imageModel {
            guard let image = imageModel.image else {
                imageCache.load(item: imageModel) {[weak self] _, image in
                    self?.image = image
                    imageModel.image = image
                }
                return
            }
            self.image = image
        }
    }
}

