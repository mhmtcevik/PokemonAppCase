//
//  SearchViewController.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import UIKit
import SnapKit

protocol SearcViewControllerOutput {
    var cards: [Card] { get }
    var loadingStatus: LoadingStatus { get }
    
    func congifureCardsData(cards: [Card])
    func reloadData()
    func favoriteAdded()
    func checkSearchResultIsEmpty(isEmpty: Bool)
    func loadingStatus(with status: LoadingStatus)
}

final class SearchViewController: ViewController {
    //MARK: UI Components
    let searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        
        return collectionView
    }()
    
    let searchContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search by Pokemon's health"
        searchBar.becomeFirstResponder()
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    let topViewBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .border
        return view
    }()
    
    let emptyImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "doc.text.magnifyingglass"))
        imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black.withAlphaComponent(0.5)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.sfProTextMedium, size: 20)
        label.textColor = .nameFont.withAlphaComponent(0.5)
        label.textAlignment = .center
        label.text = "Search result is empty"
        return label
    }()
    
    private lazy var indicatorView = UIActivityIndicatorView(style: .large)
    
    //MARK: Variables
    var cards: [Card] = []
    var loadingStatus: LoadingStatus = .completed

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupActions()
        configureConstraints()
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        
        guard let viewModel = self.viewModel as? SearchViewModel else { return }
        viewModel.viewDidLoad()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        guard let viewModel = self.viewModel as? SearchViewModel else { return }
        viewModel.setViewControllerDelegate(for: self)
    }
    
    //MARK: Functions
    func  setupViews() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        configureViews()
        
        searchCollectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.CellIdentifier.identifier.rawValue)
    }
    
    func setupActions() {
        searchBar.delegate = self
    }
    
    func configureViews() {
        view.addSubview(searchCollectionView)
        view.addSubview(searchContentView)
        searchContentView.addSubview(searchBar)
        searchContentView.addSubview(topViewBorderView)
        
        view.addSubview(indicatorView)
    }
    
    func configureConstraints() {
         searchCollectionView.snp.makeConstraints { make in
             make.bottom.leading.trailing.equalToSuperview()
             make.top.equalTo(searchContentView.snp.bottom).offset(15)
         }
         
        searchContentView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        searchBar.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.top.equalToSuperview()
        }
        
        topViewBorderView.snp.makeConstraints { make in
            make.top.equalTo(searchContentView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        indicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

}

//MARK: - CollectionView methods
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.CellIdentifier.identifier.rawValue, for: indexPath) as? SearchCell else { return UICollectionViewCell()}
        
        let card = cards[indexPath.row]
        
        guard let viewModel = viewModel as? SearchViewModel else { return UICollectionViewCell() }
        viewModel.fetchImage(path: card.imageUrl, cell: cell)
        
        cell.buttonLongTappedHandler = {
            cell.showHeartAnimation()
            viewModel.addFavoritePokemon(item: card)
        }
        
        cell.buttonShortTappedHandler = { [weak self] in
            self?.navigator.show(
                segue: .detail(viewModel: DetailViewModel(item: card, favorite: nil)),
                sender: self,
                transition: .present)
        }
        
        cell.configureActions()
        cell.configureViews()
        cell.configureConstraints()
        cell.configureData(for: card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.bounds.width  * AppConstants.CollectionView.cellSpaceRate
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return calculateCellSize(for: collectionView)
    }
    
}

//MARK: SearchBar methods
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let viewModel = viewModel as? SearchViewModel else { return }
        
        let parameters = viewModel.decideForParameter(searchString: searchText)
        viewModel.fetchCardData(parameters: parameters)
    }
    
}

//MARK: - Protocol methods
extension SearchViewController: SearcViewControllerOutput {
    func favoriteAdded() { }
    
    func reloadData() {
        searchCollectionView.reloadData()
    }
    
    func congifureCardsData(cards: [Card]) {
        self.cards = cards
    }
    
    func checkSearchResultIsEmpty(isEmpty: Bool) {
        if isEmpty && self.loadingStatus == .completed {
            guard emptyImageView.superview == nil && emptyLabel.superview == nil else { return }
            
            view.addSubview(emptyImageView)
            view.addSubview(emptyLabel)
            
            emptyImageView.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
                make.width.height.equalTo(100)
            }
            
            emptyLabel.snp.makeConstraints { make in
                make.centerX.equalTo(emptyImageView)
                make.top.equalTo(emptyImageView.snp.bottom).offset(20)
            }
        } else {
            guard emptyImageView.superview != nil && emptyLabel.superview != nil else { return }
            
            emptyImageView.removeFromSuperview()
            emptyLabel.removeFromSuperview()
        }
    }
    
    func loadingStatus(with status: LoadingStatus) {
        status == .loading ? indicatorView.startAnimating() : indicatorView.stopAnimating()
        self.loadingStatus = status
    }
    
}


