//
//  RecipeData.swift
//  Canopy
//
//  Created by Karteikay Dhuper on 8/4/22.
//

import Foundation

class RecipeData: ObservableObject{
    @Published var recipes = Recipe.testRecipes
    
    func getRecipes(for category: MainInformation.Category) -> [Recipe]{
        var filteredRecipe = [Recipe]()
        for recipe in recipes{
            if recipe.mainInformation.category == category{
                filteredRecipe.append(recipe)
            }
        }
        return filteredRecipe
    }
    
    func add(recipe: Recipe){
        if recipe.isValid{
            recipes.append(recipe)
        }
    }
    
    func getRecipeIndex(for recipe: Recipe) -> Int? {
      for i in recipes.indices {
        if recipes[i].id == recipe.id {
          return i
        }
      }
      return nil
    }
    
}
