//
//  RecipeData.swift
//  Canopy
//
//  Created by Karteikay Dhuper on 8/4/22.
//

import Foundation

class RecipeData: ObservableObject{
    @Published var recipes = Recipe.testRecipes
    
}
