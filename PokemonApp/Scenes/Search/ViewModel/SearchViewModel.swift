//
//  SearchViewModel.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import Foundation
import UIKit

protocol SearcViewModelInterface {
    var output: SearchViewController! { get set }
    
    func setViewControllerDelegate(for viewController: SearchViewController)
    func fetchCardData(parameters: Parameter)
    func decideForParameter(searchString: String?) -> Parameter
    func addFavoritePokemon(item: Card)
    func viewDidLoad()
}

class SearchViewModel: ViewModel, SearcViewModelInterface {
    
    var output: SearchViewController!
    
    override init() {
        super.init()
    }
    
    func setViewControllerDelegate(for viewController: SearchViewController) {
        output = viewController
    }
    
    func viewDidLoad() {
        self.output.checkSearchResultIsEmpty(isEmpty: ContentManager.shared.cards.isEmpty)
    }
    
    func fetchCardData(parameters: Parameter) {
        output.loadingStatus(with: .loading)
        
        fetchService.getData(path: AppConstants.API.cardPath, parameters: parameters, completionHandler: { [weak self] response in
            guard let pokemon = try? response.get() else {
                ContentManager.shared.cards = []
                self?.output.congifureCardsData(cards: ContentManager.shared.cards)
                self?.output.loadingStatus(with: .completed)
                self?.output.checkSearchResultIsEmpty(isEmpty: ContentManager.shared.cards.isEmpty)
                self?.output.reloadData()
                return
            }
         
            ContentManager.shared.cards = pokemon.cards
            self?.output.congifureCardsData(cards: ContentManager.shared.cards)
            self?.output.loadingStatus(with: .completed)
            self?.output.checkSearchResultIsEmpty(isEmpty: ContentManager.shared.cards.isEmpty)
            self?.output.reloadData()
        })
    }
    
    func fetchImage(path: String?, cell: SearchCell) {
        imageService.fetchImage(from: path, completionHandler: { result, image in
            if result {
                cell.imageView.image = image
            } else {
                cell.imageView.image = UIImage(named: "DefaultBackgroundImage")
            }
        })
    }
    
    func decideForParameter(searchString: String?) -> Parameter {
        let key = "hp"
        var healtParameter = "gte"
        
        guard let searchString = searchString else {
            return [key : healtParameter]
        }
        
        guard searchString != "" && searchString != " " else {
            return [key : healtParameter]
        }
        
        let clearSearchString = searchString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let _ = Int(clearSearchString) {
            healtParameter = "gte" + clearSearchString
            return [key : healtParameter]
        } else {
            return [key : healtParameter]
        }
    }
    
    func addFavoritePokemon(item: Card) {
        realmService.addFavorite(item: item, completionHandler: { [weak self] error in
            if let _ = error {

            } else {
                self?.output.favoriteAdded()
                print(ContentManager.shared.favoriteCards)
            }
        })
    }
    
}
