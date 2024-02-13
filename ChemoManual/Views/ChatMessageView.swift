//
//  ChatMessageView.swift
//  ChemoManual
//
//  Created by Trie Yang on 2023-11-21.
//

import SwiftUI

struct ChatMessageView: View {
    let message: Message
    
    var body: some View {
        HStack(alignment: .top) {
            if message.sender {
                Spacer()
            }
                
            MessageText(message: message).frame(maxWidth:UIScreen.main.bounds.width*0.75, maxHeight: .infinity, alignment: message.position)
            if !message.sender {
             Spacer()
            }
        }
    }
}

struct MessageText: View {
    let message: Message

    var body: some View {
        Text(message.text)
            .fontWeight(.light)
            .foregroundColor(message.textColor)
            .padding(.horizontal, 20).padding(.vertical,8)
            .background(
                message.color
            )
            .cornerRadius(20)
            .padding(.horizontal, 17)
    }
    
}


struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageView(message: Message(text: "this is a text message, hi there", sender: true))
    }
}
