//
//  SearchViewModel.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import Foundation
import UIKit

protocol SearcViewModelBehavior {
    var output: SearchViewController! { get set }
    
    func setViewControllerDelegate(for viewController: SearchViewController)
    func fetchCardData(parameters: [String : Any])
    func decideForParameter(searchString: String?) -> [String : Any]
    func addFavoritePokemon(item: Card)
}

class SearchViewModel: ViewModel, SearcViewModelBehavior {
    
    var output: SearchViewController!
    
    override init() {
        super.init()
    }
    
    func setViewControllerDelegate(for viewController: SearchViewController) {
        output = viewController
    }
    
    func fetchCardData(parameters: [String : Any]) { //TODO: bu sozluk için bir typealias yaz.
        fetchService.getData(path: AppConstants.API.cardPath, parameters: parameters, completionHandler: { [weak self] response in
            guard let pokemon = try? response.get() else { return }
            ContentManager.shared.cards = pokemon.cards
            self?.output.congifureCardsData(cards: ContentManager.shared.cards)
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
    
    func decideForParameter(searchString: String?) -> [String : Any] {
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
            if let error = error {
                //TODO: hata varsa birsey yap
            } else {
                self?.output.favoriteAdded()
                print(ContentManager.shared.favoriteCards)
            }
        })
    }
    
}
