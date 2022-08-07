//
//  ContentView.swift
//  Canopy
//
//  Created by Karteikay Dhuper on 7/24/22.
//

import SwiftUI

struct RecipesListView: View {
    @EnvironmentObject private var recipeData: RecipeData
    
    let category: MainInformation.Category
    
    
    let listBackgroundColor = AppColor.secondaryMainColor
    let ListForegroundColor = AppColor.secondaryAccentColor
    
    var body: some View {
            List{
                ForEach(recipes(for: category)){
                    recipe in
                    NavigationLink(recipe.mainInformation.name,  destination: RecipeDetailView(recipe: recipe))
                }
                .foregroundColor(ListForegroundColor)
                .listRowBackground(listBackgroundColor)
            }
            .navigationTitle(navigationTitle)
    }
}

extension RecipesListView{
    
    func recipes(for category: MainInformation.Category) -> [Recipe]{
        var filteredRecipe = [Recipe]()
        for recipe in recipeData.recipes{
            if recipe.mainInformation.category == category{
                filteredRecipe.append(recipe)
            }
        }
        return filteredRecipe
    }
    
    
//    private var recipes: [Recipe]{
//        recipeData.recipes(for: category)
//    }
    
    var navigationTitle: String{
        "\(category.rawValue) Recipes"
    }
    
}


struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
            RecipesListView(category: .breakfast).environmentObject(RecipeData())
    }
}
