//
//  ModifyRecipeView.swift
//  Canopy
//
//  Created by Karteikay Dhuper on 8/7/22.
//

import SwiftUI

struct ModifyRecipeView: View {
    @Binding var recipe: Recipe
    @State private var selection = Selection.main
        
    var body: some View {
        VStack{
            Picker("Select recipe component", selection: $selection)
            {
                Text("Main Info").tag(Selection.main)
                Text("Ingredients").tag(Selection.ingredients)
                Text("Directions").tag(Selection.directions)
            }
            .pickerStyle(.segmented)
            .padding()
            
            switch selection {
                case .main:
                ModifyMainInformationView(mainInformation: $recipe.mainInformation)
                case .ingredients:
                    ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients)
                case .directions:
                    ModifyComponentsView<Direction, ModifyDirectionView>(components: $recipe.directions)
            }
            
            Spacer()
        }//.background(AppColor.newRecListMain)
    }
    enum Selection{
        case main, ingredients, directions
    }
}

struct ModifyRecipeView_Previews: PreviewProvider {
    @State static var recipe = Recipe()
    static var previews: some View {
        ModifyRecipeView(recipe: $recipe)
    }
}
