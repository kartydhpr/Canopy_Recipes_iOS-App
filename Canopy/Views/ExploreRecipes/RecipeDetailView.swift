//
//  RecipeDetailView.swift
//  Canopy
//
//  Created by Karteikay Dhuper on 8/4/22.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: Recipe

    let listBackgroundColor = AppColor.directionsMain
    let ListForegroundColor = AppColor.directionsAccent
    let headerBackgroundColor = AppColor.mainColor
    let headerForegroundColor = AppColor.accentColor

    @State private var isPresenting = false

    var body: some View {
        VStack{
            VStack(spacing:-20){
                ZStack{
                    HStack {
                        Text(recipe.mainInformation.name)
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .padding()
                            .frame(width: 230 , alignment: .leading)
                        Spacer()
                    }
                    HStack {
                        LottieView(name: "recipe-book", loopMode: .repeatBackwards(1.5)).frame(height: 120)
                            .padding(.leading, 200)
                    }
                }
                HStack {
                    Text("**Author:** \(recipe.mainInformation.author)")
                        .font(.subheadline)
                        .padding()
                    Spacer()
                }
                HStack {
                    Text("**Description:** \(recipe.mainInformation.description)")
                        .font(.subheadline)
                        .padding()
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem {
                    HStack {
                    Button("Edit") {
                        isPresenting = true
                    }
                        Button(action: {recipe.isFavorite.toggle()
                        }){
                            Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                        }
                    }
                }
            }
            .sheet(isPresented: $isPresenting) {
                    NavigationView {
                      ModifyRecipeView(recipe: $recipe)
                        .toolbar {
                          ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                              isPresenting = false
                            }
                          }
                        }
                        .navigationTitle("Edit Recipe")
                    }
                  }
            .background(headerBackgroundColor)
            .foregroundColor(headerForegroundColor)
            .padding(.top, -60)
            
            
            List{
                Section(header: Text("Ingredients")){
                    ForEach(recipe.ingredients.indices, id: \.self){
                        index in
                        let ingredient = recipe.ingredients[index]
                        Text(ingredient.description)
                    }
                    .foregroundColor(ListForegroundColor)
                }
                .listRowBackground(listBackgroundColor)
                Section(header: Text("Directions")){
                    ForEach(recipe.directions.indices, id: \.self){
                        index in
                        let direction = recipe.directions[index]
                        HStack{
                            Text("\(index+1). ").fontWeight(.black)
                            Text("\(direction.isOptional ? "(Optional) " : "")"+"\(direction.description)").fontWeight(.semibold)
                        }
                    }.foregroundColor(ListForegroundColor)
                }.listRowBackground(listBackgroundColor)
            }.listStyle(.sidebar)
        }
        
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
  @State static var recipe = Recipe.testRecipes[0]
  static var previews: some View {
    NavigationView {
      RecipeDetailView(recipe: $recipe)
    }
  }
}
