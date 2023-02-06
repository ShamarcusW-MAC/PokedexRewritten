//
//  PokedexMainView.swift
//  PokedexRewritten
//
//  Created by Sha'Marcus Walker on 1/28/23.
//

import SwiftUI

struct PokédexMainView: View {
    
    @ObservedObject var pokemonViewModel: PokédexViewModel
    @State var isSearching = false
    @FocusState private var readyToType: Bool

    private let gridColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        GeometryReader { pokemonGeometry in
            VStack {
                HStack {
                    ZStack(alignment: .trailing) {
                        
                        if !isSearching {
                            Text("Pokédex")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.gray)
                                .background(Capsule()
                                    .foregroundColor(.red))
                                .font(.system(size: 42))
                            
                            Button {
                                //Code to search pokémon
                                readyToType = true
                                isSearching.toggle()
                                
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .frame(width: pokemonGeometry.size.width / 15, height: pokemonGeometry.size.width / 15)
                                    .foregroundColor(.black)
                                    .padding(16)
                            }
                        } else {
                            searchBarView(pokemonGeometry: pokemonGeometry)
                        }
                    }
                }
                Spacer()
                
                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: 24) {
                        ForEach(pokemonViewModel.filterPokemon, id: \.self) { pokemon in
                            Button {
                                pokemonViewModel.fetchPokemonDetail(for: pokemon)
                            } label: {
                                PokémonCellView(pokedexViewModel: pokemonViewModel, pokemon: pokemon)
                                    .task {
                                        if pokemonViewModel.hasReachedEnd(of: pokemon) && !pokemonViewModel.isFetching {
                                            
                                            await pokemonViewModel.fetchNextPokemonList()
                                            
                                        }
                                    }
                            }
                            
                        }
                    }
                    .animation(.easeInOut(duration: 0.3), value: pokemonViewModel.filterPokemon.count)
                }
            }
            .background(.black)
            .navigationDestination(for: PokémonDetailViewModel.self) { pokemonDetailViewModel in
                PokémonDetailView(pokemonDetailViewModel: pokemonDetailViewModel)
            }
        }
        
    }
    
    func searchBarView(pokemonGeometry: GeometryProxy) -> some View {
        HStack {
            
            Button {
                isSearching.toggle()
                pokemonViewModel.searchText = ""
            } label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .frame(width: pokemonGeometry.size.width / 30, height: pokemonGeometry.size.width / 20)
                    .foregroundColor(.red)
                    .padding(16)
            }

            
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: pokemonGeometry.size.width / 15, height: pokemonGeometry.size.width / 15)
                .foregroundColor(.red)
                .opacity(0.3)
            
            SuperTextField(
                placeholder:
                    Text("Search for that pokémon...")
                    .font(.system(size: 18))
                    .foregroundColor(.red),
                text: $pokemonViewModel.searchText)
            .focused($readyToType)
            .foregroundColor(.red)
            .font(.system(size: 28))
        }
        .background(Capsule()
            .foregroundColor(.gray))
    }
}


struct SuperTextField: View {
    
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
    
}

struct PokédexMainView_Previews: PreviewProvider {
    static var previews: some View {
        PokédexMainView(pokemonViewModel: PokédexViewModel.mock())
    }
}
