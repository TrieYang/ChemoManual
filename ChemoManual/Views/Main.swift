//
//  Main.swift
//  ChemoManual
//
//  Created by Trie Yang on 2023-11-07.
//

import Foundation
import SwiftUI

struct Main: Scene {
    @ObservedObject var data: DataReader = DataReader()
    @ObservedObject var textReader: TextReader = TextReader()
    @SceneStorage("experience") private var type: Type?
    @State var selection = 2
    var body: some Scene {
        WindowGroup {
            TabView(selection:$selection) {
                ChatWindowView(textReader: textReader)
               // Text("Hi")
               // Text("Hi")
                    .tabItem {
                        Label("Chat", systemImage: "ellipsis.message")
                    }.tag(1)
                
                //Text("Hi")
                MainScreen(data: data)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }.tag(2)
                //Text("Hi")
                TypePicker(type: $type, data: self.data)
                    .tabItem {
                        Label("Categories", systemImage: "rectangle.grid.2x2")
                    }.tag(3)
            }
        }
    }
}
