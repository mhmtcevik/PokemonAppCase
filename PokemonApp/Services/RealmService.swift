//
//  RealmService.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 8.10.2023.
//

import Foundation
import RealmSwift
import UIKit

enum FavoriteError: String {
    case existed = "This pokemon is already on the favorite list"
    case nonexistent = "This pokemon was not found"
}

protocol IRealmService {
    var imageService: ImageService { get }
    
    func addFavorite(item: Card, completionHandler: @escaping (_ error: FavoriteError?) -> Void)
    func removeFavorite(id: String, completionhandler: () -> Void)
}

class RealmService: IRealmService {
    
    let realm = try! Realm()
    var imageService: ImageService
    
    init() {
        imageService = ImageService()
    }
    
    func addFavorite(item: Card, completionHandler: @escaping (_ error: FavoriteError?) -> Void) {
        guard
            let id = item.id,
            let name = item.name,
            let urlString = item.imageUrl,
            let hp = item.hp
        else { return }
        
        imageService.fetchImage(from: urlString) { result, image in
            var imageData: Data?
            if result {
                imageData = image?.pngData()
            }
            
            let favorite = Favorite()
            favorite.pokemonId = id
            favorite.name = name
            favorite.imageData = imageData
            favorite.hp = hp
            
            let objects = self.realm.objects(Favorite.self)
            let existingControl = objects.where { $0.pokemonId == id }
            
            if existingControl.count > 0 {
                completionHandler(.existed)
            } else {
                do {
                    try self.realm.write {
                        self.realm.add(favorite)
                        ContentManager.shared.favoriteCards = Array(objects) //Update singleton
                        print(Array(objects))
                    }
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func removeFavorite(id: String, completionhandler: () -> Void) {
        let favorite = Favorite()
        favorite.pokemonId = id
        
        do {
            try realm.write {
                if let item = realm.objects(Favorite.self).filter(
                    { $0.pokemonId == favorite.pokemonId }).first {
                    realm.delete(item)
                }

                print(realm.objects(Favorite.self))
                ContentManager.shared.favoriteCards = getAllItems()
                completionhandler()
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    
    func getAllItems() -> [Favorite] {
        let objects = realm.objects(Favorite.self)
        return Array(objects)
    }
}
