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
    private var imageModel: Breed.ImageModel?
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
    init(_ breed: Breed,
         session: NetworkSession = URLSession.shared) {
        self.breed = breed
        self.name = breed.name
        self.referenceId = breed.referenceId?.replacingOccurrences(of: "\n",
                                                                   with: "")
        self.networkManager = NetworkManager(session: session)
        fetchimageModel()
    }

    // MARK:- Public methods
    func getImage() {
        getImageCalled = true
        guard let imageModel = imageModel else {
            fetchimageModel()
            return
        }
        fetchImage(imageModel)
    }
    func unbind() {
        showImage.unbind()
    }
}

// MARK:- Private extension
private extension BreedCellViewModel {
    
    func fetchimageModel() {
        guard let referenceID = referenceId else {
            image = placeholderImage
            return
        }
        networkManager.fetchimageModel(for: referenceID) {
            [weak self] (response) in
            switch response {
            // Handle the failure
            case .failure( _):
                self?.image = self?.placeholderImage
            // Handle success
            case .success(let imageModel):
                self?.breed.imageModel = imageModel
                self?.imageModel = imageModel
                if self?.getImageCalled == true {
                    self?.fetchImage(imageModel)
                }
            }
        }
    }

    func fetchImage(_ imageModel: Breed.ImageModel) {
        guard let image = imageModel.image else {
            ImageCache.publicCache.load(item: imageModel) { [weak self] data, image in
                if data.url == imageModel.url {
                    self?.image = image
                }
            }
            return
        }
        self.image = image
    }
}

