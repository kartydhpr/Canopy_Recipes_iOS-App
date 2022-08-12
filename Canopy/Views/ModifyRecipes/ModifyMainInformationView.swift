//
//  ModifyMainInformationView.swift
//  Canopy
//
//  Created by Karteikay Dhuper on 8/9/22.
//

import SwiftUI

struct ModifyMainInformationView: View {
    @Binding var mainInformation: MainInformation
    private let listBack = AppColor.secondaryMainColor
    private let listFore = AppColor.secondaryAccentColor
    
    var body: some View {
        Form{
            TextField("Recipe Name", text: $mainInformation.name).listRowBackground(listBack)
            TextField("Author", text: $mainInformation.author).listRowBackground(listBack)
            Section(header: Text("Description")){
                TextEditor(text: $mainInformation.description).listRowBackground(listBack)
            }
            Section(header: Text("Category")){
                Picker(selection: $mainInformation.category, label:
                    HStack{
                        Text("Category").foregroundColor(listFore)
                        Spacer()
                        Text(mainInformation.category.rawValue).foregroundColor(listFore)

                }){
                    ForEach(MainInformation.Category.allCases, id: \.self) {category in
                        Text(category.rawValue).foregroundColor(listFore)

                    }
                }
                .listRowBackground(listBack)
                .foregroundColor(listFore)
                .pickerStyle(.menu)
            }
        }
        .foregroundColor(listFore)

    }
}

struct ModifyMainInformationView_Previews: PreviewProvider {
    @State static var emptyInformation = MainInformation(name: "", description: "", author: "", category: .breakfast)
    static var previews: some View {
        ModifyMainInformationView(mainInformation: $emptyInformation)
    }
}
