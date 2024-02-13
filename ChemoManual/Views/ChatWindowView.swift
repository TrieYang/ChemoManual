//
//  ChatWindowView.swift
//  ChemoManual
//
//  Created by Trie Yang on 2023-11-22.
//

import SwiftUI
import Combine


struct ChatWindowView: View {
    @Namespace var bottomID
    @ObservedObject var textReader: TextReader
    
    @ObservedObject var refreshTrigger = TriggerViewModel()
    @State private var theId = 0
    private let objectWillChange = ObservableObjectPublisher()
    var body: some View {
        ZStack(alignment: .top) {
           Rectangle().fill(Color.white).frame(maxHeight: 60).ignoresSafeArea().zIndex(1)
            VStack {
                Spacer().frame(height: 30).background(.white)
                ScrollViewReader { proxy in
                    VStack {
                        
                        ScrollView {
                            
                            VStack {
                                //display the messages
                                ForEach(textReader.messageSet, id: \.self) { message in
                                    ChatMessageView(message: Message(text: message.message, sender: message.sender))
                                }.onChange(of: textReader.messageSet.count) { _ in proxy.scrollTo(bottomID)} // scroll to bottom whenever the number of messages changes
                                
                            }
                            Text("").id(bottomID)
                            
                        }.frame(maxWidth:UIScreen.main.bounds.width*0.96)                .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        
                        TextSenderView(textReader: self.textReader)
                        Spacer()
                            .frame(height: 20.0)
                    }
                    .onAppear {proxy.scrollTo(bottomID)}
                }
            }.zIndex(0)
            
            
        }.background(.white)
               
        }
        
    }
    


func color(fraction: Double) -> Color {
    Color(red: fraction, green: 1 - fraction, blue: 0.5)
}



//struct ChatWindowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatWindowView()
//    }
//}

class TriggerViewModel: ObservableObject {
    func updateView() {
        self.objectWillChange.send()
    }
}
