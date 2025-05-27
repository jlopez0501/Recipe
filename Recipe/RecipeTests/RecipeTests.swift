//
//  RecipeTests.swift
//  RecipeTests
//
//  Created by Joshua Lopez on 5/15/25.
//

import Testing
@testable import Recipe

struct RecipeTests {

    @Test func testFavoritesManagerSavingAndLoading() async throws {
        let manager = FavoritesManager.shared
        let testRecipeId = "test_recipe_123"
        
        // Test adding favorite
        manager.toggleFavorite(recipeId: testRecipeId)
        #expect(manager.isFavorite(recipeId: testRecipeId))
        
        // Test removing favorite
        manager.toggleFavorite(recipeId: testRecipeId)
        #expect(!manager.isFavorite(recipeId: testRecipeId))
        
        // Test persistence
        manager.toggleFavorite(recipeId: testRecipeId)
        let newManager = FavoritesManager.shared // Create new instance to test loading
        #expect(newManager.isFavorite(recipeId: testRecipeId))
    }
    
    @Test func testUserDefaultsKeys() async throws {
        let testRecipeId = "test_recipe_456"
        
        // Test favorites key constant
        #expect(AppConstants.UserDefaults.favoritesKey == "favoriteRecipes")
        
        // Test recipe notes key generation
        let notesKey = AppConstants.UserDefaults.recipeNotesKey(for: testRecipeId)
        #expect(notesKey == "recipe_notes_test_recipe_456")
    }

}
