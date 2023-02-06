//
//  PokedexEndpoionts.swift
//  PokedexRewritten
//
//  Created by Sha'Marcus Walker on 1/27/23.
//

import Foundation

struct PokedexEndpoint<Response: Decodable> {
    let url: URL
    let responseType: Response.Type
}

class Endpoints {
    
    static func pokemonListings(for start: Int) ->
        PokedexEndpoint<PokédexPage>{
            PokedexEndpoint(url: URL(string: "https://pokeapi.co/api/v2/pokemon?offset=\(start)&limit=30")!, responseType: PokédexPage.self)
        }
    
    static func detailPokemon(for pokemon: Pokémon) ->
    PokedexEndpoint<PokémonDetail>{
        PokedexEndpoint(url: URL(string: pokemon.url)!, responseType: PokémonDetail.self)
    }
}
