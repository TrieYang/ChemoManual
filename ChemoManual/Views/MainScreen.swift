//
//  MainScreen.swift
//  ChemoManual
//
//  Created by Trie Yang on 2023-11-03.
//

import SwiftUI
import FMDB



    


struct MainScreen: View {
    
    //var theDatabase = FMDatabase(url: URL(string: "ChemoManualDB.db"))
        
    //theDatabase.open()
   
    
    
    @ObservedObject var data: DataReader
    @State private var searchText = ""
    
    var body: some View {
        
        
        NavigationStack {
        VStack {
            
            var posts = data.searchDB(keyWord: searchText)
            
            
                ScrollView {
                    VStack {
                        ForEach(posts, id: \.self) { post in
                            NavigationLink(destination: ContentView(title: post.name, content: post.content)) {
                                CardView(question: post.name, partialAnswer: String(post.content.prefix(130)), image: post.image)
                                //Text("image is" + post.image)
                                
                            }
                        }
                        
                    }.frame(width:UIScreen.main.bounds.width*scrollWidth)
                }
                
        }
        }.searchable(text: $searchText)
    }
}

//struct MainScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MainScreen(searchText: $)
//    }
//}

