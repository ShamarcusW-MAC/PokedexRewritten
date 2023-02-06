//
//  ApplicationController.swift
//  PokedexRewritten
//
//  Created by Sha'Marcus Walker on 1/30/23.
//

import Foundation

class ApplicationController {
    let networkManager = NetworkManager()
    
    static func mock() -> ApplicationController {
        ApplicationController()
    }
    
    lazy var pokemonViewModel: PokédexViewModel = {
        PokédexViewModel(app: self)
    }()
}
