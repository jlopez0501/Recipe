//
//  RecipeAPI.swift
//  Recipe
//
//  Created by Joshua Lopez on 5/16/25.
//

import Foundation

struct Response: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable, Identifiable {
    let cuisine: String
    let name: String
    let photo_url_large: String
    let photo_url_small: String
    let source_url: String?
    let uuid: String
    let youtube_url: String?
    
    var id: String {
        uuid
    }
    
}

enum RecipeError: Error {
    case invalidData
    case networkError(Error)
    case decodingError(Error)
}

func fetchRecipes() async -> [Recipe] {
    do {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let response = try JSONDecoder().decode(Response.self, from: data)
            print("Fetched \(response.recipes.count) recipes")
            return response.recipes
        } catch {
            print("Error decoding recipes: \(error)")
            return []
        }
    } catch {
        print("Network error fetching recipes: \(error)")
        return []
    }
}

func getCuisines(_ recipes: [Recipe]) -> Set<String> {
    print("getCuisines called")
    var cuisines: Set<String> = []
    for recipe in recipes {
        cuisines.insert(recipe.cuisine)
    }
    return cuisines
}



