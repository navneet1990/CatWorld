//
//  CWSearchViewController.swift
//  CatWorld
//

import UIKit

class CWSearchViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- Lazy Variables
    /* View Model variable will be load lazily.
     It will be loaded in memory when called first time
     **/
    lazy var viewModel : CWSearchViewModel = {
        let viewModel = CWSearchViewModel()
        return viewModel
    }()
    
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.setEmptyMessage("Welcome")
        unbindViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        viewModel.memoryWarning()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        if segue.destination is CWDetailViewController {
            let vc = segue.destination as? CWDetailViewController
            vc?.viewModel = viewModel.detailsViewModel
        }
    }
}

private extension CWSearchViewController {
    func unbindViewModel() {
        viewModel.reloadData.bind({ _ in
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.setContentOffset(.zero,
                                                      animated: true)
                self?.collectionView.reloadData()
                self?.searchBar.isLoading = false
            }
        })
        
        viewModel.showAlert.bind { [weak self] alertAction in
            guard let action = alertAction else { return }
            self?.presentAlert(action)
        }
        
        viewModel.backgroundMessage.bind { [weak self] (show,message) in
            DispatchQueue.main.async {
                if show {
                    self?.collectionView.setEmptyMessage(message)
                } else {
                    self?.collectionView.restore()
                }
            }
        }
        viewModel.showDetails.bind { _ in
            DispatchQueue.main.async { [weak self] in
                self?.performSegue(CWDetailViewController.self)
            }
        }
        
        viewModel.searchBarLoading.bind { value in
            DispatchQueue.main.async { [weak self] in
                self?.searchBar.isLoading = value
            }
        }
    }
}

//MARK:- Search Bar Methods
extension CWSearchViewController: UISearchBarDelegate {
    // 1
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        viewModel.searchCats(for: searchText)
    }
    
    // 2
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.searchTextField.resignFirstResponder()
    }
    
    // 3
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
}

// MARK: - UICollectionViewDataSource
extension CWSearchViewController: UICollectionViewDataSource {
    // 1
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.totalItems
    }
    // 2
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        // 1
        guard let breedViewModel = viewModel.breedsViewModel[safe: indexPath.row],
              let cell = collectionView.dequeueReusableCell(
               withReuseIdentifier: viewModel.reuseIdentifier,
               for: indexPath) as? BreedCell else {
            return .init()
        }
        cell.viewModel = breedViewModel
        return cell
    }
}

// MARK: - Collection View Flow Layout Delegate
extension CWSearchViewController: UICollectionViewDelegateFlowLayout {
    // 1
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // 2
        let paddingSpace = Layout.leftInsetPadding * (Layout.itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / Layout.itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}

// MARK: - UICollectionView DataSource
extension CWSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
        collectionView.deselectItem(at: indexPath,
                                    animated: true)
    }
}

// MARK: - UIScroll View Delegate
extension CWSearchViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

// MARK:- View Controller Layout Info
private extension CWSearchViewController {
    struct Layout {
        static let itemsPerRow: CGFloat = 2
        static let leftInsetPadding: CGFloat = 5
        
    }
}
