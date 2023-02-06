//
//  PokedexPage.swift
//  PokedexRewritten
//
//  Created by Sha'Marcus Walker on 1/27/23.
//

import Foundation

struct PokédexPage: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokémon]
}


struct Pokémon: Decodable, Identifiable, Equatable, Hashable {
    let id = UUID()
    let name: String
    let url: String
}
