//
//  PokemonAPI.swift
//  Pokedex-Hybrid-Objc-Swift
//
//  Created by Dongwoo Pae on 11/23/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

//https://pokeapi.co/api/v2/pokemon
//https://pokeapi.co/api/v2/pokemon/golem

@objc(DWPokemonAPI)
class PokemonAPI: NSObject {
    
    var baseUrl = URL(string: "https://pokeapi.co/api/v2/")!
    
    @objc(sharedController)
    static let shared = PokemonAPI()
    
    @objc
    func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let pokemonListUrl = baseUrl.appendingPathComponent("pokemon")
        
        var urlComponents = URLComponents(url: pokemonListUrl, resolvingAgainstBaseURL: true)
        let limitQueryItem = URLQueryItem(name: "limit", value: "964")
        urlComponents?.queryItems = [limitQueryItem]
        
        guard let urlRequest = urlComponents?.url else {return}
        
        var request = URLRequest(url: urlRequest)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("there is an error in getting the list of pokemon: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("there is no data")
                completion(nil, error)
                return
            }
            
            do {
                
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    let error = NSError(domain: "UserControllerErrorDomain", code: 1, userInfo: nil);
                    throw error
                }
                
                guard let pokemonDictionaries = dictionary["results"] as? [[String : Any]] else {
                    let error = NSError(domain: "UserControllerErrorDomain", code: 2, userInfo: nil);
                    throw error
                }
                
                let pokemons = pokemonDictionaries.compactMap {Pokemon(dictionary: $0)}
                print(pokemons)
                print(pokemons[0].name)
                completion(pokemons, nil)
                
            } catch {
                NSLog("there is an error in encoding data \(error)")
                completion(nil, error)
            }
        }.resume()
    }
    
    @objc(fetchSprite:completionHandler:)
    func fetchPokemonImage(for imageURLString: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let urlRequest = URL(string: imageURLString)!
        
        var request = URLRequest(url: urlRequest)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, error)
                return
            }
            let image = UIImage(data: data)
            completion(image, nil)
        }.resume()
    }
    
    @objc
    func fillInDetails(for pokemon: Pokemon) {
        
    }
}
