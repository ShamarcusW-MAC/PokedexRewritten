//
//  PokedexRewrittenApp.swift
//  PokedexRewritten
//
//  Created by Sha'Marcus Walker on 1/27/23.
//

import SwiftUI

@main
struct PokedexRewrittenApp: App {
    
    let app = ApplicationController()
    var body: some Scene {
        WindowGroup {
            RootView(pokedexViewModel: app.pokemonViewModel)
        }
    }
}
