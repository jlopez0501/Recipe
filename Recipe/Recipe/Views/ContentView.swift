//
//  ContentView.swift
//
//  Created by Joshua Lopez on 5/15/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RecipeViewModel()
    
    var body: some View {
        ZStack {
            Color.mutedOrange.opacity(0.05).ignoresSafeArea(.all)
            
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
            } else if let error = viewModel.error {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 50))
                        .foregroundColor(.orange)
                    
                    Text(errorMessage(for: error))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button("Try Again") {
                        Task {
                            await viewModel.loadRecipes()
                        }
                    }
                    .buttonStyle(.bordered)
                }
            } else if viewModel.recipes.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "fork.knife")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    
                    Text("No recipes available")
                        .font(.headline)
                    
                    Button("Refresh") {
                        Task {
                            await viewModel.loadRecipes()
                        }
                    }
                    .buttonStyle(.bordered)
                }
            } else {
                VStack {
                    ScrollView(.horizontal) {
                        FilterView(cuisine_filter: $viewModel.selectedCuisine, cuisines: $viewModel.cuisines)
                    }
                    RecipeGridView(recipes: $viewModel.recipes, cuisine_filter: viewModel.selectedCuisine)
                }
            }
        }
        .task {
            await viewModel.loadRecipes()
        }
        .refreshable {
            await viewModel.loadRecipes()
        }
    }
    
    private func errorMessage(for error: RecipeError) -> String {
        switch error {
        case .invalidData:
            return "The recipe data appears to be invalid or empty. Please try again later."
        case .networkError:
            return "Unable to connect to the server. Please check your internet connection and try again."
        case .decodingError:
            return "There was a problem processing the recipe data. Please try again later."
        }
    }
}

#Preview {
    ContentView()
}
