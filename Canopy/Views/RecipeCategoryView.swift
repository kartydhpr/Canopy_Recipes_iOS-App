//
//  RecipeCategoryView.swift
//  Canopy
//
//  Created by Karteikay Dhuper on 8/6/22.
//
import SwiftUI

struct RecipeCategoryView: View {
  private var recipeData = RecipeData()
 
  var body: some View {
    NavigationView {
        VStack(spacing: 20){
            LottieView(name: "recipes", loopMode: .playOnce).frame(width:500, height: 130)
                .padding(.leading, -5)
            
            Text("What are we making?")
                .font(.title2)
                .bold()
            HStack(spacing: 20){
                NavigationLink(destination: RecipesListView(category: .breakfast).environmentObject(recipeData), label: {
                    CardView(cardName: "Breakfast", imageName: "cup.and.saucer.fill")
                })
                NavigationLink(destination: RecipesListView(category: .lunch).environmentObject(recipeData), label: {
                    CardView(cardName: "Lunch", imageName: "takeoutbag.and.cup.and.straw.fill")
                })
            }
            HStack(spacing: 20){
                
                NavigationLink(destination: RecipesListView(category: .dinner).environmentObject(recipeData), label: {
                    CardView(cardName: "Dinner", imageName: "moon.stars.fill")
                })
                NavigationLink(destination: RecipesListView(category: .treats).environmentObject(recipeData), label: {
                    CardView(cardName: "Treats", imageName: "fork.knife.circle.fill")
                })
            }
            Spacer()
        }
        .navigationTitle("Categories")
        .navigationBarHidden(false)
        
    }
  }
}

struct RecipeCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCategoryView()
    }
}
