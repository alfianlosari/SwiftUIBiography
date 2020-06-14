//
//  SectionCarousel.swift
//  Biography
//
//  Created by Alfian Losari on 14/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct SectionCarousel: View {
    
    let section: PersonSection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(section.name)
                .font(.system(size: 20, weight: .regular))
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(section.picturesImageName, id: \.self) { name in
                        Image(name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                    }
                }
                .padding(.vertical)
                .padding(.horizontal)
            }
        }
        .padding(.bottom)
    }
}


struct SectionCarousel_Previews: PreviewProvider {
    static var previews: some View {
        SectionCarousel(section: Person.stubbed[0].sections![0])
    }
}
