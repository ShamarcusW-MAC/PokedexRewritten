//
//  PokemonDetailView.swift
//  PokedexRewritten
//
//  Created by Sha'Marcus Walker on 1/28/23.
//

import SwiftUI

struct PokémonDetailView: View {
    
    @ObservedObject var pokemonDetailViewModel: PokémonDetailViewModel
    
    var body: some View {
        
        GeometryReader { pokemonGeometry in
            VStack(spacing: 0) {
                
                HStack {
                    
                    AsyncImage(url: URL(string: pokemonDetailViewModel.pokemonDetail.sprites.frontDefault))
                        .frame(width: pokemonGeometry.size.width / 5, height: pokemonGeometry.size.height / 5)
                    
                    Text(pokemonDetailViewModel.pokemonDetail.name.capitalized)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.red))
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                    
                    AsyncImage(url: URL(string: pokemonDetailViewModel.pokemonDetail.sprites.frontShiny))
                        .frame(width: pokemonGeometry.size.width / 5, height: pokemonGeometry.size.height / 5)
                    
                }

                HStack {
                    ForEach(pokemonDetailViewModel.pokemonDetail.types) { type in
                        Text(type.type.name.capitalized)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .background(Capsule()
                                .foregroundColor(Color(type.type.name.capitalized)))
                            .padding(16)
                    }
                }

                HStack {
                    Text("Weight: \(pokemonDetailViewModel.pokemonDetail.weight) lbs")
                        .foregroundColor(.white)
                Spacer()
                    Text("Height: \(pokemonDetailViewModel.pokemonDetail.height)")
                        .foregroundColor(.white)
                Spacer()
                    Text("Base XP: \(pokemonDetailViewModel.pokemonDetail.baseExperience)")
                        .foregroundColor(.white)
                }
                
                Spacer()

                
                Text("Abilities")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .background(Rectangle()
                        .foregroundColor(.red))
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                
                List(pokemonDetailViewModel.pokemonDetail.abilities) { ability in
                
                    Text(ability.ability.name)
                        .font(.system(size: 28))
                        .foregroundColor(.red)
                
                }
                
                Text("Moves")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .background(Rectangle()
                        .foregroundColor(.red))
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                
                List(pokemonDetailViewModel.pokemonDetail.moves) { move in
                    
                    HStack {
                        Text(move.move.name)
                            .font(.system(size: 28))
                            .foregroundColor(.red)
                        
                        Spacer()
                        
                        Text("Level: \(move.versionGroupDetails.last?.levelLearnedAt ?? 0)")
                            .font(.system(size: 28))
                            .foregroundColor(.red)
                    }
                }
                Spacer()
            }
            .background(.black)
        }
    }
}

struct PokémonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokémonDetailView(pokemonDetailViewModel: PokémonDetailViewModel.mock())
    }
}
