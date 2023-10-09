//
//  FavoriteViewModel.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import Foundation
import UIKit

protocol FavoriteViewModelInterface {
    var outPut: FavoriteViewController! { get set }
    
    func viewWillAppear()
    func setViewControllerDelegate(for viewController: FavoriteViewController)
    func setFavoriteData()
    func removeFavorite(id: String)
}

class FavoriteViewModel: ViewModel, FavoriteViewModelInterface {
    
    var outPut: FavoriteViewController!
    
    override init() {
        super.init()
    }
    
    func viewWillAppear() {
        setFavoriteData()
    }
    
    func setViewControllerDelegate(for viewController: FavoriteViewController) {
        outPut = viewController
    }
    
    func setFavoriteData() {
        ContentManager.shared.favoriteCards = realmService.getAllItems()
        let data = ContentManager.shared.favoriteCards.sorted { $0.pokemonId < $1.pokemonId}
        outPut.congifureCardsData(cards: data)
        outPut.reloadData()
    }
    
    func removeFavorite(id: String) {
        realmService.removeFavorite(id: id) {
            setFavoriteData()
            outPut.favoriteDeleted()
        }
    }
    
}
