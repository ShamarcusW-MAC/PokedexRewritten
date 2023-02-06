//
//  NetworkManager.swift
//  PokedexRewritten
//
//  Created by Sha'Marcus Walker on 1/29/23.
//

import Foundation

class NetworkManager {
    
    lazy var decoder: JSONDecoder = {
        JSONDecoder()
    }()
    
    func fetch<Response>(endpoint: PokedexEndpoint<Response>) async throws -> Response {
        let (data, response) = try await URLSession.shared.data(from: endpoint.url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        print(("data = \(data)"))
//        let jsonData = try decoder.decode(Response.self, from: data)
        return try decoder.decode(Response.self, from: data)
    }
}
