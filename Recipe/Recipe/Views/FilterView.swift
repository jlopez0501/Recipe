//
//  FilterView.swift
//  Recipe
//
//  Created by Joshua Lopez on 5/20/25.
//

import SwiftUI

struct FilterView: View {
    @Binding var cuisine_filter: String
    @Binding var cuisines: Set<String>
    @StateObject private var favoritesManager = FavoritesManager.shared
    
    // Have a variable that stores the cuisine selected and send that over to the RecipeGridView. ForEach iteration, check in an If statement if the recipe.cuisine matches the cuisine selected.
        
    var body: some View {
        HStack {
            Button(action: {
                if cuisine_filter == "favorites" {
                    cuisine_filter = ""
                } else {
                    cuisine_filter = "favorites"
                }
            }) {
                Image(systemName: cuisine_filter == "favorites" ? "heart.fill" : "heart")
                    .foregroundStyle(Color.red)
                    .font(.system(size: 20))
                    .frame(height: 32)
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle(radius: 8))
            .background(cuisine_filter == "favorites" ? Color.red.opacity(0.1) : Color.clear)
            .cornerRadius(8)
            
            ForEach(Array(cuisines), id: \.self) { cuisine in
                Button(action: {
                    if cuisine_filter == cuisine {
                        cuisine_filter = ""
                    } else {
                        cuisine_filter = cuisine
                    }
                }) {
                    Text(cuisine)
                        .foregroundStyle(cuisine == cuisine_filter ? Color.plum : Color.primary)
                        .frame(height: 32)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .background(cuisine == cuisine_filter ? Color.plum.opacity(0.1) : Color.clear)
                .cornerRadius(8)
                .scaleEffect(cuisine == cuisine_filter ? 1.05 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: cuisine_filter)
            }
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 5)
    }
}

//#Preview {
//    FilterView()
//}
