//
//  ModifyMainInformationView.swift
//  Canopy
//
//  Created by Karteikay Dhuper on 8/9/22.
//

import SwiftUI

struct ModifyMainInformationView: View {
    @Binding var mainInformation: MainInformation
    
    private let listBack = AppColor.newRecListMain
    private let listFore = Color.black
    private let header = AppColor.newRecListAccent

    
    var body: some View {
        Form{
            Section(header: Text("Recipe Name and Author")){
                TextField("Recipe Name", text: $mainInformation.name)//.listRowBackground(listBack)
                TextField("Author", text: $mainInformation.author)//.listRowBackground(listBack)
            }
            Section(header: Text("Description")){
                TextEditor(text: $mainInformation.description)//.listRowBackground(listBack)
            }
            Section(header: Text("Category")){
                Picker(selection: $mainInformation.category, label:
                    HStack{
                        Text("Category").foregroundColor(listFore)
                        Spacer()
                        Text(mainInformation.category.rawValue).foregroundColor(listFore)

                }){
                    ForEach(MainInformation.Category.allCases, id: \.self) {category in
                        Text(category.rawValue)//.foregroundColor(listFore)

                    }
                }
//                .listRowBackground(listBack)
                .pickerStyle(.menu)
            }
        }
//        .foregroundColor(listFore)

    }
}

struct ModifyMainInformationView_Previews: PreviewProvider {
    @State static var emptyInformation = MainInformation(name: "", description: "", author: "", category: .breakfast )
    static var previews: some View {
        ModifyMainInformationView(mainInformation: $emptyInformation)
    }
}
