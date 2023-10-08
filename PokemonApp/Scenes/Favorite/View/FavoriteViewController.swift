//
//  FavoriteViewController.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import UIKit

protocol FavoriteControllerOutput {
    var favoriteItems: [Favorite] { get }
    
    func reloadData()
    func favoriteDeleted()
    func congifureCardsData(cards: [Favorite])
}

final class FavoriteViewController: ViewController {
    //MARK: UI Components
    let favoriteCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        
        return collectionView
    }()
    
    let favoriteTopView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let topViewBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .border
        return view
    }()
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.sfProTextMedium, size: 28)
        label.textColor = .nameFont
        label.textAlignment = .center
        label.text = "Favorites"
        return label
    }()
    
    //MARK: Variables
    var favoriteItems: [Favorite] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        configureConstraints()
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let viewModel = self.viewModel as? FavoriteViewModel else { return }
        viewModel.viewWillAppear()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        guard let viewModel = self.viewModel as? FavoriteViewModel else { return }
        viewModel.setViewControllerDelegate(for: self)

    }
    
    //MARK: Functions
    func  setupViews() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        configureViews()
        
        favoriteCollectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.CellIdentifier.identifier.rawValue)
    }
    
    func configureViews() {
        view.addSubview(favoriteCollectionView)
        
        view.addSubview(favoriteTopView)
        favoriteTopView.addSubview(topLabel)
        favoriteTopView.addSubview(topViewBorderView)
    }
    
    func configureConstraints() {
         favoriteCollectionView.snp.makeConstraints { make in
             make.bottom.leading.trailing.equalToSuperview()
             make.top.equalTo(favoriteTopView.snp.bottom).offset(15)
         }
         
        favoriteTopView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        topLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        topViewBorderView.snp.makeConstraints { make in
            make.top.equalTo(favoriteTopView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
}

extension FavoriteViewController: FavoriteControllerOutput {
    
    func congifureCardsData(cards: [Favorite]) {
        favoriteItems = cards
    }
    
    func reloadData() {
        favoriteCollectionView.reloadData()
    }
    
    func favoriteDeleted() {
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.CellIdentifier.identifier.rawValue, for: indexPath) as? FavoriteCell else { return UICollectionViewCell()}
        
        let favoriteCard = favoriteItems[indexPath.row]
        
        if let viewModel = viewModel as? FavoriteViewModel {
            cell.configureActions()
            cell.configureData(for: favoriteCard)
            
            cell.buttonTappedHandler = {
                viewModel.removeFavorite(id: favoriteCard.pokemonId)
            }

            cell.configureViews()
            cell.configureConstraints()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.bounds.width  * AppConstants.CollectionView.cellSpaceRate
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return calculateCellSize(for: collectionView)
    }
    
}
