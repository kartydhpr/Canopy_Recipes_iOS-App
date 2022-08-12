//
//  ContentView.swift
//  Canopy
//
//  Created by Karteikay Dhuper on 7/24/22.
//

import SwiftUI

struct RecipesListView: View {
    @EnvironmentObject private var recipeData: RecipeData
    @State var isPresenting: Bool = false
    @State var newRecipe = Recipe()
    
    let category: MainInformation.Category
    
    let listBackgroundColor = AppColor.secondaryMainColor
    let ListForegroundColor = AppColor.secondaryAccentColor
    
    var body: some View {
            List{
                ForEach(recipeData.getRecipes(for: category)){
                    recipe in
                    NavigationLink(recipe.mainInformation.name,  destination: RecipeDetailView(recipe: recipe))
                }
                .foregroundColor(ListForegroundColor)
                .listRowBackground(listBackgroundColor)
            }
            .navigationTitle(navigationTitle)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action:{
                        isPresenting = true
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(AppColor.secondaryAccentColor)
                    })
                }
            })
            .sheet(isPresented: $isPresenting, content: {
                NavigationView{
                    ModifyRecipeView(recipe: $newRecipe)
                        .toolbar(content: {
                            ToolbarItem(placement: .cancellationAction){
                                Button("Dismiss"){
                                    isPresenting = false
                                }
                            }
                            ToolbarItem(placement: .navigationBarTrailing){
                                if newRecipe.isValid{
                                    Button("Add"){
                                        recipeData.add(recipe: newRecipe)
                                        isPresenting = false
                                    }
                                }
                            }
                        })
                        .navigationTitle("Add a New Recipe")
                }
            })
            
    }
}

extension RecipesListView{
    
//    func getRecipes(for category: MainInformation.Category) -> [Recipe]{
//        var filteredRecipe = [Recipe]()
//        for recipe in recipeData.recipes{
//            if recipe.mainInformation.category == category{
//                filteredRecipe.append(recipe)
//            }
//        }
//        return filteredRecipe
//    }
//    
    
//    private var recipes: [Recipe]{
//        recipeData.recipes(for: category)
//    }
    
    var navigationTitle: String{
        "\(category.rawValue) Recipes"
    }
    
}


struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListView( category: .breakfast).environmentObject(RecipeData())
    }
}
