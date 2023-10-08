//
//  AppConstants.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import Foundation

enum AppConstants {
    
    struct API {
        static let baseURL = "https://api.pokemontcg.io/v1"
        static let cardPath = "/cards"
    }
    
    struct CollectionView {
        static let cellSpaceRate: Double = 17.0 / 375.0
        static let totalContentInset: Double = (24 * 2)
        static let cellHeightRate: Double = (200 / width)
        static let width: Double = 150.0
    }
}
