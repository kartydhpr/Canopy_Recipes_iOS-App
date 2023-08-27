//
//  ModifyIngredientsView.swift
//  Canopy
//
//  Created by Karteikay Dhuper on 8/9/22.
//

import SwiftUI

struct ModifyIngredientView: ModifyComponentView {
        
    @Binding var ingredient: Ingredient
    let createAction: ((Ingredient) -> Void)
    
    init(component: Binding<Ingredient>, createAction: @escaping (Ingredient) -> Void) {
       self._ingredient = component
       self.createAction = createAction
     }
    
    private let listBack = AppColor.newRecListMain
    private let listFore = Color.black
    private let header = AppColor.newRecListAccent
    
    @Environment(\.presentationMode) private var mode
    
    var body: some View {
        Form{
            TextField("Ingredient Name", text: $ingredient.name)
            Stepper(value: $ingredient.quantity, in: 0...1000, step: 0.5)
            {
                HStack{
                    Text("Quantity: ")
                    TextField("Quantity", value: $ingredient.quantity, format: .number)
                        .keyboardType(.numbersAndPunctuation)
                }
            }
            Picker(selection: $ingredient.unit, label:
                HStack{
                    Text("Unit")
                    Spacer()
                    Text(ingredient.unit.rawValue)
            })
            {
                ForEach(Ingredient.Unit.allCases, id: \.self){ unit in
                    Text(unit.rawValue)
                }
            }
            .pickerStyle(.menu)
            HStack{
                Spacer()
                Button("Save"){
                    createAction(ingredient)
                    mode.wrappedValue.dismiss()
                }
                Spacer()
            }
        }
    }
}

struct ModifyIngredientView_Previews: PreviewProvider {
  @State static var emptyIngredient = Recipe.testRecipes[0].ingredients[0]
  static var previews: some View {
    NavigationView {
      ModifyIngredientView(component: $emptyIngredient) { ingredient in
        print(ingredient)
      }
    }.navigationTitle("Add Ingredient")
  }
}
