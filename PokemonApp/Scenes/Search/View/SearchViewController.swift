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
    
    func congifureCardsData(cards: [Card])
    func reloadData()
    func favoriteAdded()
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
    
    //MARK: Variables
    var cards: [Card] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupActions()
        configureConstraints()
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        
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
            make.width.equalToSuperview()
            make.bottom.top.equalToSuperview()
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
        
        cell.buttonTappedHandler = {
            cell.button.isUserInteractionEnabled = false
            cell.showHeartAnimation()
            viewModel.addFavoritePokemon(item: card)
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

//MARK:
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let viewModel = viewModel as? SearchViewModel else { return }
        
        let parameters = viewModel.decideForParameter(searchString: searchText)
        
        viewModel.fetchCardData(parameters: parameters)
    }
    
}

//MARK: - Protocol methods
extension SearchViewController: SearcViewControllerOutput {
    func favoriteAdded() {
    
    }
    
    func reloadData() {
        searchCollectionView.reloadData()
    }
    
    func congifureCardsData(cards: [Card]) {
        self.cards = cards
    }
    
}


