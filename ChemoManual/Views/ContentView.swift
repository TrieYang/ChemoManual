//
//  ContentView.swift
//  ChemoManual
//
//  Created by Trie Yang on 2023-11-15.
//

import SwiftUI

struct ContentView: View {
    var title: String
    var content: String
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                    .fontWeight(.heavy)
                Text(content)
                    .font(.body)
                    .fontWeight(.light)
                    .padding(.top)
            }
            .frame(maxWidth: UIScreen.main.bounds.width*0.8)
        }
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(title: "Test",
                    content: "how are you")
    }
}
