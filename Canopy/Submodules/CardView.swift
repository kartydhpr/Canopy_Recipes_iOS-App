//
//  CardView.swift
//  Canopy
//
//  Created by Karteikay Dhuper on 8/6/22.
//

import SwiftUI

struct CardView: View {
    let cardName: String
    let imageName: String
    var body: some View {
        VStack(spacing: 17.0){ // button outside formatting
            VStack { // button inside formatting
                Image(systemName:imageName).font(.largeTitle)
                    .foregroundColor(Color.orange)

                Text(cardName)
                    .font(.title3)
                    .foregroundColor(Color.black)
                    .bold()
                    .padding()
            }
        }
        .frame(width: 170, height: 170)
        .background(Color.white)
        .cornerRadius(17.0)
        .shadow(color: Color.gray, radius: 5)    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(cardName: "Breakfast", imageName: "cup.and.saucer.fill")
    }
}
