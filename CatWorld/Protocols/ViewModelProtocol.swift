//
//  ViewModelProtocol.swift
//  CatWorld
//

import UIKit

protocol ViewModelProtocol: AnyObject {
    //Variables
    var reuseIdentifier: String { get }
    var breedsViewModel: [BreedCellViewModel] { get set }
    var detailsViewModel: CWDetailViewModel? { get }
    var showAlert: Bindable<(SingleButtonAlert)?> { get set }
    var searchBarLoading: Bindable<(Bool)> { get set }
    var showDetails: Bindable<Void> { get set }
    var backgroundMessage: Bindable<(Bool, String)> { get set }

    // Methods
    func searchCats(for text: String?)
    func didSelectItem(at: IndexPath)
    func memoryWarning()
}



// MARK:- Details View Model Protocol
protocol DetailsViewModelProtocol: AnyObject {
    //Variables
    var name: String { get }
    var hideWikipedia: Bool { get }
    var temperant: String? { get }
    var energy: String? { get }
    var displayDetails: Bindable<Void> { get set }
    var loadImage: Bindable<Void> { get set }
    var redirectToSafari: Bindable<URL?> { get set }

    // Methods
    func loadDetails()
    func openWikipedia()
}

// MARK:- Breed Cell View Model Protocol
protocol BreedCellViewModelProtocol: AnyObject {
    //Variables
    var showImage: Bindable<Void> { get set }
    var image: UIImage? { get set }
    var name: String { get }

    // Methods
    func getImage()
    func unbind()
}
