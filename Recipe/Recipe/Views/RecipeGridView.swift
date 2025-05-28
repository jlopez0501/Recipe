//
//  RecipeGridView.swift
//  Recipe
//
//  Created by Joshua Lopez on 5/15/25.
//

import SwiftUI

struct RecipeGridView: View {
    @Binding var recipes: [Recipe]
    let cuisine_filter: String
    @StateObject private var favoritesManager = FavoritesManager.shared
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var filteredRecipes: [Recipe] {
        if cuisine_filter == "favorites" {
            return recipes.filter { favoritesManager.isFavorite(recipeId: $0.uuid) }
        } else if cuisine_filter.isEmpty {
            return recipes
        } else {
            return recipes.filter { $0.cuisine == cuisine_filter }
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(filteredRecipes) { recipe in
                    RecipePreviewCard(recipe: recipe)
                        .padding(.horizontal, 8)
                }
            }
        }
        .refreshable {
            do {
                let refreshed_recipes = try await fetchRecipes()
                recipes = refreshed_recipes
            } catch {
                print("Error refreshing recipes")
            }
        }
    }
    
}
