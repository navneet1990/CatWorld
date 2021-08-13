//
//  CWDetailViewModel.swift
//  CatWorld
//

import UIKit

final class CWDetailViewModel {

    //MARK:- Properties
    private let wikipedia: URL?
    let name: String
    let hideWikipedia: Bool
    let temperant: String?
    let energy: String?
    var image: UIImage?

    var displayDetails: Bindable<Void> = Bindable(())
    var reloadImage: Bindable<Void> = Bindable(())
    var redirectToSafari: Bindable<URL?> = Bindable(nil)

    // MARK:- Intialization
    init(breed: Breed) {
        self.name = breed.name
        self.wikipedia = URL(string: breed.wikipedia ?? "")
        if let energy = breed.energyLevel {
            self.energy = String(describing: energy)
        } else {
            energy = nil
        }
        self.temperant = breed.temperament
        self.hideWikipedia = breed.wikipedia == nil
        guard let item = breed.imageData else {
            return
        }
        loadImage(item)
    }

    // MARK:- Public methods
    func loadDetails() {
        displayDetails.value = ()
    }
    func openWikipedia() {
        redirectToSafari.value = wikipedia
    }

    private func loadImage(_ item: Breed.ImageData) {
        guard let image = item.image else {
            ImageCache.publicCache.load(item: item) {[weak self] _, image in
                self?.image = image
                item.image = image
                self?.reloadImage.value = ()
            }
           return
        }
        self.image = image
    }
}

