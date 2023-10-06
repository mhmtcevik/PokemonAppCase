//
//  StorageAPI.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import Foundation

protocol StorageAPIProtocol {
    func getData(path: String, completionHandler: @escaping (Result<Pokemon, NSError>) -> Void)
}

class StorageAPI: BaseAPI<StorageNetworking>, StorageAPIProtocol {
    
    func getData(path: String, completionHandler: @escaping (Result<Pokemon, NSError>) -> Void) {
        self.fetchData(target: .getStorage(path: path), responseClass: Pokemon.self) { result in
            completionHandler(result)
        }
    }

}
