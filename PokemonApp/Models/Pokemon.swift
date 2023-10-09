//
//  Pokemon.swift
//  PokemonApp
//
//  Created by Mehmet Çevık on 5.10.2023.
//

import Foundation

struct Pokemon: Codable {
    let cards: [Card]
}

struct FavoriteItem: Codable {
    let card: Card
}

// MARK: - Welcome
struct Card: Codable {
    let id: String?
    let name: String?
    let supertype: String?
    let imageUrl: String?
    let subtypes: [String?]?
    let hp: String?

    enum CodingKeys: String, CodingKey {
        case id, name, supertype, subtypes, hp, imageUrl
    }
}
