//
//  FilteredCards.swift
//  ChemoManual
//
//  Created by Trie Yang on 2023-11-08.
//

import SwiftUI


struct FilteredCards: View {
    @ObservedObject var data: DataReader
    var filterType: Type
    var body: some View {
        
        var titleNames = data.filterDB(typeParam: filterType)
 
        ScrollView {
            VStack {
                ForEach(titleNames, id: \.self) { titleName in
                    NavigationLink(destination: ContentView(title: titleName.name, content: titleName.content)) {
                        CardView(question: titleName.name, partialAnswer: String(titleName.content.prefix(60)), image:titleName.image)
                    }
                }
            }
        }
    }
}

struct FilteredCards_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hi") // change later
    }
}
