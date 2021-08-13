//
//  ViewModelProtocol.swift
//  CatWorld
//

import Foundation

protocol ViewModelProtocol: AnyObject {
    //Variables
    var breedsViewModel: [BreedCellViewModel] { get set }
    var detailsViewModel: CWDetailViewModel? { get }
    var showAlert: Bindable<(SingleButtonAlert)?> { get set }
    var searchBarLoading: Bindable<(Bool)> { get set }
    var reloadItemAt: Bindable<(indexPath: IndexPath, data: Breed.ImageData)?> { get set }
    var showDetails: Bindable<Void> { get set }
    var backgroundMessage: Bindable<(Bool, String)> { get set }

    // Methods
    func searchCats(for text: String?)
    func didSelectItem(at: IndexPath)
    func memoryWarning()
}



protocol DetailsViewModelProtocol: AnyObject {
    var displayDetails: Bindable<Void> { get set }
    var reloadImage: Bindable<Void> { get set }
    var redirectToSafari: Bindable<URL?> { get set }

    func loadDetails()
    func openWikipedia()
}

protocol BreedCellViewModelProtocol: AnyObject {
    func getImage()
    func unbind()
}
