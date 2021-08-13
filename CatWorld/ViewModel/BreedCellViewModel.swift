//
//  BreedCellViewModel.swift
//  CatWorld
//

import UIKit

final class BreedCellViewModel: BreedCellViewModelProtocol {

    // MARK:- Variables
    private let placeholderImage = UIImage(named: "noImageAvailabe")
    private let breed: Breed
    private let referenceId: String?
    private let networkManager: NetworkManager
    private var imageData: Breed.ImageData?
    private var getImageCalled = false

    let name: String

    var showImage: Bindable<Void> = Bindable(())
    var image: UIImage? = nil {
        didSet {
            getImageCalled = false
            showImage.value = ()
        }
    }

    // MARK:- Initialization
    init(_ breed: Breed, session: NetworkSession = URLSession.shared) {
        self.breed = breed
        self.name = breed.name
        self.referenceId = breed.referenceId?.replacingOccurrences(of: "\n",
                                                                   with: "")
        self.networkManager = NetworkManager(session: session)
        fetchImageData()
    }

    func getImage() {
        getImageCalled = true
        guard let imageData = imageData else {
            fetchImageData()
            return
        }
        fetchImage(imageData)
    }
    func unbind() {
        showImage.unbind()
    }
}

// MARK:- Private extension
private extension BreedCellViewModel {
    
     func fetchImageData() {
         guard let referenceID = referenceId else {
             image = placeholderImage
             return
         }
         networkManager.fetchImageData(for: referenceID) {
             [weak self] (response) in
             switch response {
             // Handle the failure
             case .failure( _):
                 self?.image = self?.placeholderImage
             // Handle success
             case .success(let imageData):
                 self?.breed.imageData = imageData
                 self?.imageData = imageData
                 if self?.getImageCalled == true {
                     self?.fetchImage(imageData)
                 }
             }
         }
     }

      func fetchImage(_ imageData: Breed.ImageData) {
         guard let image = imageData.image else {
             ImageCache.publicCache.load(item: imageData) { [weak self] data, image in
                 if data.url == imageData.url {
                 self?.image = image
                 }
             }
             return
         }
         self.image = image
     }
}

