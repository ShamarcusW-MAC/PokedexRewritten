//
//  PokedexViewModel.swift
//  PokedexRewritten
//
//  Created by Sha'Marcus Walker on 1/27/23.
//

import Foundation
import SwiftUI

class PokédexViewModel: ObservableObject {
    
    static func mock() -> PokédexViewModel {
        PokédexViewModel(app: ApplicationController.mock())
    }

    
    @Published var pokemonDetail: PokémonDetail?
    @Published var pokemonList = [Pokémon]()
    @Published var navigationPath = NavigationPath()
    @Published private(set) var state: State?
    
    var start = 0
    var maxLimit = 150
    var paginatedPokemonList = [Pokémon]()
    
    @Published var searchText = ""

    var filterPokemon: [Pokémon] {
        return searchText == "" ? pokemonList : pokemonList.filter {
            $0.name.starts(with: (searchText.lowercased()))
        }
    }
    
    let app: ApplicationController
    init(app: ApplicationController) {
        self.app = app
        fetchPokemonList()
    }
    
    
    var isLoading:  Bool {
        state == .loading
    }
    
    var isFetching:  Bool {
        state == .fetching
    }
    
    
    private var fetchPokemonTask: Task<Void, Never>?

    func fetchPokemonList() {
        

        fetchPokemonTask?.cancel()
        
        fetchPokemonTask = Task {
            
            await MainActor.run {
                state = .loading
                do { state = .finished }
            }
            
            do {                
                let _pokemonList = try await app.networkManager.fetch(endpoint: Endpoints.pokemonListings(for: self.start))
                await MainActor.run {
                    self.pokemonList = _pokemonList.results
                    self.start = self.pokemonList.count
                }
                
                
                print("Pokemon List Received: \(pokemonList)")
            } catch let error {
                await MainActor.run {
                    print("Failure \(error)")
                }
            }
        }
    }
    
    func fetchNextPokemonList() async {
        
        guard self.pokemonList.count != maxLimit else { return }
         
        fetchPokemonTask = Task {
            do {
                
                await MainActor.run {
                    state = .fetching
                    do { state = .finished }
                }
                
                let _pokemonPage = try await app.networkManager.fetch(endpoint: Endpoints.pokemonListings(for: self.start))
                
                await MainActor.run {
                    
                    self.pokemonList += _pokemonPage.results
                    self.start = self.pokemonList.count
                    print("Pokemon List Received: \(_pokemonPage.results)")

                }
                
            } catch let error {
                await MainActor.run {
                    
                    print("Failure \(error)")
                }
            }
        }
    }
    
    @MainActor
    func fetchPokemonIndex(pokemon: Pokémon) -> Int {
        if let index = self.pokemonList.firstIndex(of: pokemon) {
            return index + 1
        }
        return 0
        
    }
    
    @MainActor
    func hasReachedEnd(of pokemon: Pokémon) -> Bool {
        pokemonList.last?.id == pokemon.id
    }

    
    private var fetchPokemonDetailTask: Task<Void, Never>?

    func fetchPokemonDetail(for pokemon: Pokémon) {
        fetchPokemonDetailTask = Task {
            do {
                
                let _pokemonDetail = try await app.networkManager.fetch(endpoint: Endpoints.detailPokemon(for: pokemon))
                
                print("Pokemon detail received: \(_pokemonDetail.name) \(_pokemonDetail.baseExperience)")
                
                await MainActor.run {
                    self.pokemonDetailViewModelSpawn(pokemonDetail: _pokemonDetail)
                    if let pokemonDetailViewModel = self.pokemonDetailViewModel {
                        navigationPath.append(pokemonDetailViewModel)
                    }
                }
            } catch let error {
                print("Error fetching detail: \(error)")
            }
        }
    }
    
    private (set) var pokemonDetailViewModel: PokémonDetailViewModel?
    
    private func pokemonDetailViewModelSpawn(pokemonDetail: PokémonDetail) {
        pokemonDetailViewModel = PokémonDetailViewModel(pokemonViewModel: self, pokemonDetail: pokemonDetail)
    }
    
    
    private func pokemonDetailViewModelDispose() {
        self.pokemonDetailViewModel = nil
    }
    
    func nameString(for pokemon: Pokémon) -> String {
        return pokemon.name
    }
}

extension PokédexViewModel {
    enum State {
        case fetching
        case loading
        case finished
    }
}
