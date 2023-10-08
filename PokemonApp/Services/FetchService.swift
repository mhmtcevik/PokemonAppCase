//
//  StorageAPI.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import Foundation

protocol FetchAPI{
    func getData(path: String, parameters: [String: Any], completionHandler: @escaping (Result<Pokemon, NSError>) -> Void)
    func getItemById(path: String, itemId: String, completionHandler: @escaping (Result<FavoriteItem, NSError>) -> Void)
}

class FetchService: BaseAPI<Networking>, FetchAPI {
    
    func getItemById(path: String, itemId: String, completionHandler: @escaping (Result<FavoriteItem, NSError>) -> Void) {
        self.fetchData(target: .getItemById(path: path, itemId: itemId), responseClass: FavoriteItem.self) { result in
            completionHandler(result)
        }
    }
    
    func getData(path: String, parameters: [String: Any], completionHandler: @escaping (Result<Pokemon, NSError>) -> Void) {
        self.fetchData(target: .getSearchItems(path: path, parameters: parameters), responseClass: Pokemon.self) { result in
            completionHandler(result)
        }
    }

}
