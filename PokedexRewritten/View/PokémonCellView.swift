//
//  PokémonCellView.swift
//  PokedexRewritten
//
//  Created by Sha'Marcus Walker on 1/29/23.
//

import SwiftUI

struct PokémonCellView: View {
    
    @ObservedObject var pokedexViewModel: PokédexViewModel
    let pokemon: Pokémon
    
    var body: some View {
        ZStack {
            VStack {
                pokemonImage(spriteURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokedexViewModel.fetchPokemonIndex(pokemon: pokemon)).png")
                
                
                
                Text(pokedexViewModel.nameString(for: pokemon).capitalized)
                    .foregroundColor(.red)
                    .font(.system(size: 20))
                    .padding([.top, .bottom], 4)
            }
            .padding([.leading, .trailing, .top], 4)
        }.cellBox(backgroundColor: Color.black, strokeColor: Color.red, cornerRadius: 8, strokeWidth: 3)
    }
    
    
    
    func pokemonImage(spriteURL: String) -> some View {
        VStack {
            
            AsyncImage(url: URL(string: spriteURL))
            { image in
                if let image = image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 115, height: 100)
                }
                
            } placeholder: {
                ProgressView()
                    .frame(width: 60, height: 60)
            }
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

struct PokémonCellView_Previews: PreviewProvider {
    static var previews: some View {
        PokémonCellView(pokedexViewModel: PokédexViewModel.mock(), pokemon: Pokémon(name: "bulbasaur", url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png"))
    }
}
