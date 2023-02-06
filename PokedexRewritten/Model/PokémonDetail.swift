//
//  PokemonDetail.swift
//  PokedexRewritten
//
//  Created by Sha'Marcus Walker on 1/27/23.
//

import Foundation

struct PokémonDetail: Decodable, Hashable {
    let abilities: [Ability]
    let baseExperience: Int
    let forms: [Species]
    let gameIndices: [GameIndex]
    let height: Int
    let id: Int
    let isDefault: Bool
    let locationAreaEncounters: String?
    let moves: [Move]
    let name: String
    let order: Int
    let species: Species
    let sprites: Sprites
    let stats: [Stat]
    let types: [TypeElement]
    let weight: Int
    
    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case forms
        case gameIndices = "game_indices"
        case height, id
        case isDefault = "is_default"
        case locationAreaEncounters = "local_area_encounters"
        case moves, name, order, species, sprites, stats, types, weight
    }
    
}

struct Ability: Decodable, Identifiable {
    let id = UUID()
    let ability: Species
    let isHidden: Bool
    let slot: Int
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct Species: Decodable {
    let name: String
    let url: String
}

struct GameIndex: Decodable {
    let gameIndex: Int?
    let version: Species
}

struct Move: Decodable, Identifiable {
    let id = UUID()
    let move: Species
    let versionGroupDetails: [VersionGroupDetails]
    
    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

struct VersionGroupDetails: Decodable {
    let levelLearnedAt: Int
    let moveLearnMethod: Species
    let versionGroup: Species
    
    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}

struct Sprites: Decodable {
    let backDefault: String
    let backFemale: String?
    let backShiny: String
    let backShinyFemale: String?
    let frontDefault: String
    let frontFemale: String?
    let frontShiny: String
    let frontShinyFemale: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

struct Stat: Decodable {
    let baseStat: Int
    let effort: Int
    let stat: Species
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

struct TypeElement: Decodable, Identifiable {
    let id = UUID()
    let slot: Int
    let type: Species
}


extension PokémonDetail {
    
    static func mock() -> PokémonDetail {
        let jsonString = ""
        let jsonData = jsonString.data(using: .utf8)!
        return try! JSONDecoder().decode(PokémonDetail.self, from: jsonData)

    }
    
    
    static func == (lhs: PokémonDetail, rhs: PokémonDetail) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
