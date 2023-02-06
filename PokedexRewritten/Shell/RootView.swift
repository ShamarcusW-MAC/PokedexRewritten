//
//  RootView.swift
//  PokedexRewritten
//
//  Created by Sha'Marcus Walker on 1/30/23.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var pokedexViewModel: PokédexViewModel

    var body: some View {
        NavigationStack(path: $pokedexViewModel.navigationPath) {
            PokédexMainView(pokemonViewModel: pokedexViewModel)
        }
    }
}
