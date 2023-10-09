//
//  Favorite.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 8.10.2023.
//

import Foundation
import RealmSwift

class Favorite: Object {
    @Persisted var pokemonId: String
    @Persisted var name: String
    @Persisted var imageData: Data?
    @Persisted var hp: String?
}
