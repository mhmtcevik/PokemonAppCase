//
//  FavoriteViewModel.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import Foundation
import UIKit

protocol FavoriteViewModelBehavior {
    var outPut: FavoriteViewController! { get set }
    
    func viewWillAppear()
    func setViewControllerDelegate(for viewController: FavoriteViewController)
    func setFavoriteData()
    //func fetchItem(id: String, completionhandler: @escaping (_ card: FavoriteItem?) -> Void)
    func removeFavorite(id: String)
}

class FavoriteViewModel: ViewModel, FavoriteViewModelBehavior {
    
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
    /*
     func fetchItem(id: String, completionhandler: @escaping (_ card: FavoriteItem?) -> Void) {
         fetchService.getItemById(path: AppConstants.API.cardPath, itemId: id) { result in
             guard let card = try? result.get() else { return }
             completionhandler(card)
         }
     }

    
    func fetchImage(path: String?, cell: FavoriteCell) {
        imageService.fetchImage(from: path, completionHandler: { result, image in
            if result {
                cell.imageView.image = image
            } else {
                cell.imageView.image = UIImage(named: "DefaultBackgroundImage")
            }
        })
    }
     */

    
    func removeFavorite(id: String) {
        realmService.removeFavorite(id: id) {
            setFavoriteData()
            outPut.favoriteDeleted()
        }
    }
    
}
