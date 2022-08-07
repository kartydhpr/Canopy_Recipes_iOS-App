//
//  RecipeDetailView.swift
//  Canopy
//
//  Created by Karteikay Dhuper on 8/4/22.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    let listBackgroundColor = AppColor.mainColor
    let ListForegroundColor = AppColor.accentColor
    let headerBackgroundColor = AppColor.secondaryMainColor
    let headerForegroundColor = AppColor.secondaryAccentColor

    
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
                        LottieView(name: "recipe-book", loopMode: .repeatBackwards(2.5)).frame(height: 120)
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
        RecipeDetailView(recipe: recipe)
    }
}
