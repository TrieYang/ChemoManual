//
//  Message.swift
//  ChemoManual
//
//  Created by Trie Yang on 2023-11-21.
//

import SwiftUI

class Message {
    let text: String
    let sender: Bool
    let color: Color
    let textColor: Color
    let position: Alignment
    
    init(text: String, sender: Bool) {
        self.text = text
        self.sender = sender
        //self.time = time
        if sender {
            // blue
            self.color = /*@START_MENU_TOKEN@*/Color(hue: 0.585, saturation: 0.696, brightness: 1.0)/*@END_MENU_TOKEN@*/
            textColor = Color(.white)
            position = .trailing
        } else {
            // black
            self.color = Color(hue: 1.0, saturation: 0.0, brightness: 0.939)
            textColor = Color(.black)
            position = .leading
        }
    }
}
