//
//  CWSearchViewModel.swift
//  CatWorld
//

import Foundation

final class CWSearchViewModel: ViewModelProtocol {
    
    //MARK:- Variables
    private var networkManager: NetworkManager?
    private var updateQtyTimer: Timer?
    private var searchText: String = ""

    let reuseIdentifier = "BreedCell"
    var totalItems: Int = 0
    var showAlert: Bindable<(SingleButtonAlert)?> = Bindable(nil)
    var backgroundMessage: Bindable<(Bool, String)> = Bindable((false, ""))
    var showDetails: Bindable<Void> = Bindable(())
    var reloadData: Bindable<Void> = Bindable(())
    var searchBarLoading: Bindable<(Bool)> = Bindable(false)

    // Details View Model
    var detailsViewModel: CWDetailViewModel? = nil {
        didSet {
            guard let _ = detailsViewModel else {
                return
            }
            showDetails.value = ()
        }
    }
    /* private breeds variable
     This will hold all the breeds.
     If network fails it will dispaly last fetch data
     **/
    var breedsViewModel : [BreedCellViewModel] = []

    /* private breeds variable
     This will hold all the breeds.
     If network fails it will dispaly last fetch data
     **/
    private var breeds : [Breed] = [] {
        didSet {
            totalItems = breeds.count
            if totalItems > 0 {
                backgroundMessage.value = (false, "")
            } else {
                backgroundMessage.value = (true,
                                           "No results Found. \nSearch some other breed..")
            }
            ImageCache.publicCache.cancelAllRequest()
            breedsViewModel = breeds.map { BreedCellViewModel($0) }

            reloadData.value = ()
        }
    }
    
    /* private Error details
     * This will hold the Error details.
     **/
    private var errorDetails : ErrorResult?{
        didSet{
            // Display error
            guard let title = errorDetails?.title,
                  let description = errorDetails?.description,
                  let message = errorDetails?.backgroundMessage else { return }
            let action = AlertAction(buttonTitle: "Ok",handler: nil)
            searchBarLoading.value = false
            showAlert.value = SingleButtonAlert(title: title,
                                                message: description,
                                                action: action)
            backgroundMessage.value = (true, message)
        }
    }

    //MARK:- Init Method
    init(_ session: NetworkSession = URLSession.shared) {
        self.networkManager = NetworkManager(session: session)
    }

    //MARK:- Public Methods
    func searchCats(for text: String?) {
        guard let text = text else {
            return
        }
        // Remove any extra white space
        searchText = text.trimmingCharacters(in: .whitespacesAndNewlines)

        // Verify if searched text is not empty string
        guard !searchText.isEmpty else {
            breeds.removeAll()
            return
        }
        scheduleUpdateTimer()
    }

    // Will navigate to details view controller on cell tap
    func didSelectItem(at indexPath: IndexPath) {
        let breed = breeds[indexPath.row]
        detailsViewModel = CWDetailViewModel(breed: breed)
    }


    // Incase there is memory warning, it will clear the cache
    func memoryWarning() {
        ImageCache.publicCache.clearCache()
    }

}

// MARK:- Private methods
private extension CWSearchViewModel {
    
    // Fetch typed text
    func  fetch(_ query: String) {
        searchBarLoading.value = true
        networkManager?.fetchCatsFromServer(search: query) {
            [weak self] (response) in
            switch response {
            // Handle the failure
            case .failure(let error):
                self?.errorDetails = error
            // Handle success
            case .success(let breeds):
                self?.breeds = breeds
            }
        }
    }

    private func scheduleUpdateTimer() {
        updateQtyTimer?.invalidate()
        updateQtyTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.fetch(self.searchText)
        }
    }
}
