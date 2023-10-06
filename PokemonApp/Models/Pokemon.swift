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

// MARK: - Card
struct Card: Codable {
    let id, name: String
    let nationalPokedexNumber: Int
    let imageURL, imageURLHiRes: String
    let types: [RetreatCost]
    let supertype: Supertype
    let subtype: Subtype
    let hp: String
    let retreatCost: [RetreatCost]?
    let convertedRetreatCost: Int?
    let number, artist: String
    let rarity: String?
    let series: Series
    let cardSet: String?
    let setCode: String
    let text: [String]?
    let attacks: [Attack]?
    let weaknesses: [Resistance]
    let ability: Ability?
    let evolvesFrom: String?
    let resistances: [Resistance]?
    let ancientTrait: AncientTrait?

    enum CodingKeys: String, CodingKey {
        case id, name, nationalPokedexNumber
        case imageURL = "imageUrl"
        case imageURLHiRes = "imageUrlHiRes"
        case types, supertype, subtype, hp, retreatCost, convertedRetreatCost, number, artist, rarity, series
        case cardSet = "set"
        case setCode, text, attacks, weaknesses, ability, evolvesFrom, resistances, ancientTrait
    }
}

// MARK: - Ability
struct Ability: Codable {
    let name, text: String
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case ability = "Ability"
    case pokéBody = "Poké-Body"
    case pokéPower = "Poké-Power"
}

// MARK: - AncientTrait
struct AncientTrait: Codable {
    let name, text: String
}

// MARK: - Attack
struct Attack: Codable {
    let cost: [RetreatCost]
    let name, text, damage: String
    let convertedEnergyCost: Int
}

enum RetreatCost: String, Codable {
    case colorless = "Colorless"
    case darkness = "Darkness"
    case dragon = "Dragon"
    case fairy = "Fairy"
    case fighting = "Fighting"
    case fire = "Fire"
    case grass = "Grass"
    case lightning = "Lightning"
    case metal = "Metal"
    case psychic = "Psychic"
    case water = "Water"
}

// MARK: - Resistance
struct Resistance: Codable {
    let type: RetreatCost
    let value: String
}

enum Series: String, Codable {
    case blackWhite = "Black & White"
    case diamondPearl = "Diamond & Pearl"
    case eCard = "E-Card"
    case ex = "EX"
    case heartGoldSoulSilver = "HeartGold & SoulSilver"
    case platinum = "Platinum"
    case sunMoon = "Sun & Moon"
    case swordShield = "Sword & Shield"
    case xy = "XY"
}

enum Subtype: String, Codable {
    case basic = "Basic"
    case ex = "EX"
    case levelUp = "Level Up"
    case mega = "MEGA"
    case stage1 = "Stage 1"
    case stage2 = "Stage 2"
    case v = "V"
    case vmax = "VMAX"
}

enum Supertype: String, Codable {
    case pokémon = "Pokémon"
}
