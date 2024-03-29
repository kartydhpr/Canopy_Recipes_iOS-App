//
//  ModifyIngredientsView.swift
//  Canopy
//
//  Created by Karteikay Dhuper on 8/9/22.
//

import SwiftUI

protocol RecipeComponent: CustomStringConvertible {
  init()
  static func singularName() -> String
  static func pluralName() -> String
}

extension RecipeComponent {
  static func singularName() -> String {
    String(describing: self).lowercased()
  }
  static func pluralName() -> String {
    self.singularName() + "s"
  }
}

protocol ModifyComponentView: View {
    associatedtype Component
    init(component: Binding<Component>, createAction: @escaping (Component) -> Void)
}

struct ModifyComponentsView<Component: RecipeComponent, DestinationView: ModifyComponentView>: View where DestinationView.Component == Component {
  @Binding var components: [Component]
  @State private var newComponent = Component()
 
  var body: some View {
    VStack {
      let addComponentView = DestinationView(component: $newComponent) { component in
        components.append(component)
        newComponent = Component()
      }.navigationTitle("Add \(Component.singularName().capitalized)")
      if components.isEmpty {
        Spacer()
        NavigationLink(destination: addComponentView, label: {
          VStack(spacing:20){
            Image(systemName: "note.text.badge.plus").font(.system(size: 100))
            Text("Add the first \(Component.singularName())").font(.title2).bold()
          }.foregroundColor(AppColor.newRecListMain)
        })
        Spacer()
      } else {
        HStack {
          Text(Component.pluralName().capitalized)
            .font(.title)
            .padding()
          Spacer()
        }
        List {
          ForEach(components.indices, id: \.self) { index in
            let component = components[index]
            let editComponentView = DestinationView(component: $components[index]) { _ in
                return
                }
                .navigationTitle("Edit" + "\(Component.singularName().capitalized)")
                NavigationLink(component.description, destination: editComponentView)
            Text(component.description)
          }
          .onDelete { components.remove(atOffsets: $0) }
          .onMove { indices, newOffset in
              components.move(fromOffsets: indices, toOffset: newOffset)
          }
          
          .listRowBackground(AppColor.mainColor)
                .foregroundColor(AppColor.accentColor)
          NavigationLink("Add another \(Component.singularName())",
                         destination: addComponentView)
            .buttonStyle(PlainButtonStyle())
        }
      }
    }
  }
}
 
struct ModifyIngredientsView_Previews: PreviewProvider {
  @State static var recipe = Recipe.testRecipes[1]
  @State static var emptyIngredients = [Ingredient]()
  static var previews: some View {
    NavigationView {
      ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients)
    }
  }
}
