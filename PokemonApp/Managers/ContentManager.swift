//
//  ContentService.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 7.10.2023.
//

import Foundation

class ContentManager {
    
    static let shared = ContentManager()
    private init() { }
    
    var cards: [Card] = []
    var favoriteCards: [Favorite] = []
}
