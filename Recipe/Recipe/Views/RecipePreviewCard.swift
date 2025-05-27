//
//  RecipePreviewCard.swift
//  Recipe
//
//  Created by Joshua Lopez on 5/15/25.
//

import SwiftUI

struct RecipePreviewCard: View {
    var food_image: String
    var name: String
    var quisine: String
    
    var body: some View {
        Button(action: {}) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 125, height: 145)
                    .foregroundStyle(Color.orange)
                    
                VStack {
                    AsyncImage(url: URL(string: food_image)) { result in result.image?
                        .resizable()
                        .scaledToFit()
                    }
                    .frame(width: 100)
                    Group {
                        Text(name)
                            .fontWeight(.bold)
                        Text(quisine)
                    }
                    .font(.system(size: 12))
                    .foregroundStyle(Color.white)
                    
                }
            }
        }
    }
}

//#Preview {
//    RecipePreviewCard(food_image: <#String#>, name: <#String#>, quisine: <#String#>)
//}
