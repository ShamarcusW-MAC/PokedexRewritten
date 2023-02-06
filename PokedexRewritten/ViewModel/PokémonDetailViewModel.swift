//
//  PokémonDetailViewModel.swift
//  PokedexRewritten
//
//  Created by Sha'Marcus Walker on 1/30/23.
//

import Foundation

class PokémonDetailViewModel: ObservableObject {
    
    static func mock() -> PokémonDetailViewModel {
        PokémonDetailViewModel(pokemonViewModel: PokédexViewModel.mock(), pokemonDetail: PokémonDetail.mock())
    }
    
    let pokemonViewModel: PokédexViewModel
    let pokemonDetail: PokémonDetail
        
    init(pokemonViewModel: PokédexViewModel,  pokemonDetail: PokémonDetail) {
        self.pokemonViewModel = pokemonViewModel
        self.pokemonDetail = pokemonDetail
        
        print("Pokemon Detail View Model created")
    }
    
    deinit{
        print("Pokemon Detail View Model destroyed")
    }
    
}

extension PokémonDetailViewModel: Hashable {
    static func == (lhs: PokémonDetailViewModel, rhs: PokémonDetailViewModel) -> Bool {
        lhs.pokemonDetail.id == rhs.pokemonDetail.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(pokemonDetail.id)
    }
}
