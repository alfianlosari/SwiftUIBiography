//
//  CardView.swift
//  Biography
//
//  Created by Alfian Losari on 14/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    var person: Person
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Image(person.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                Text(person.shortDescription)
                    .font(.body)
                    .lineSpacing(5)
                    .lineLimit(4)
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: screen.bounds.width * 0.75)
                    .background(Color.black.opacity(0.5))
            }
            .frame(width: screen.bounds.width * 0.75, height: screen.bounds.height * 0.60)
            .cornerRadius(16)
            .shadow(radius: 8)
            
            Text(person.name)
                .font(.system(size: 30, weight: .medium))
                .foregroundColor(Color.black)
        }
    }
}
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(person: Person.stubbed[0])
    }
}
