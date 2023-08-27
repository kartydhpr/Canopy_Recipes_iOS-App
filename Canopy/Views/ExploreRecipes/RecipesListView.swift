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
    
    let listBackgroundColor = AppColor.mainColor
    let ListForegroundColor = AppColor.accentColor
    
    var body: some View {
            List{
                ForEach(recipeData.getRecipes(for: category)){
                    recipe in
                    NavigationLink(recipe.mainInformation.name,
                                         destination: RecipeDetailView(recipe: binding(for: recipe)))                }
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
                            .foregroundColor(AppColor.newRecListMain)
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
//
//    private var recipes: [Recipe]{
//        recipeData.recipes(for: category)
//    }
    
    var navigationTitle: String{
        "\(category.rawValue) Recipes"
    }
    
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        guard let index = recipeData.getRecipeIndex(for: recipe) else {
          fatalError("Recipe not found")
        }
        return $recipeData.recipes[index]
      }
}


struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListView( category: .breakfast).environmentObject(RecipeData())
    }
}
