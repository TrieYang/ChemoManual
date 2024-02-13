//
//  TextSenderView.swift
//  ChemoManual
//
//  Created by Trie Yang on 2023-11-22.
//

import SwiftUI

struct TextSenderView: View {
    @State private var textInput = ""
    @State public var buttonState: Bool = false
    @State var containHeight: CGFloat = 0
    @StateObject var textReader: TextReader
    
    
    var body: some View {
        HStack {
            

            AutoSizingTF(
                hint: "Please enter your question...",
                text: $textInput,
                containerHeight: $containHeight,
                buttonState: $buttonState
                
            )
            .padding(.horizontal)
            .frame(height: containHeight < 120 ? containHeight : 120)
            .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.480, opacity: 0.1))
            .cornerRadius(10)
            .padding(.leading, 15.0)
            
       
            
            
            Button("Send") {
                if textInput != "" {
                    buttonState = true
                    textReader.insertText(textMessage: TextSet(message: textInput, sender: true))
                    respond(message: textInput, senderTextReader: textReader)
                    textInput = ""
                }
            }.padding().background(Color(hue: 0.585, saturation: 0.696, brightness: 1.0)).frame(maxHeight: 40).foregroundColor(.white).cornerRadius(15).padding(.trailing, 15)
            
        }
    }
}


//struct TextSenderView_Previews: PreviewProvider {
//    static var previews: some View {
//        TextSenderView(textReader: TextReader())
//    }
//}

//封装自适应文本框组件AutoSizingTF
struct AutoSizingTF: UIViewRepresentable {
    //参数列表
    var hint: String //Placeholder占位
    @Binding var text: String //文本
    @Binding var containerHeight: CGFloat //文本框高度
    @Binding var buttonState: Bool
    @State var button: Bool = false
    
    
    func makeCoordinator() -> Coordinator {
        return AutoSizingTF.Coordinator(parent:  self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView() //实例化文本框组件
        //原生组件样式控制
        textView.text = hint
        textView.textColor = .gray
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 20)
        textView.delegate = context.coordinator
        button = buttonState
        return textView
    }
    
    
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        //自适应文本高度函数
        DispatchQueue.main.async {
            if containerHeight == 0 {
                //将内容文本的高度赋值给弹性文本框的高度变量
                containerHeight = uiView.contentSize.height
            }
            
            if buttonState == true {
                uiView.text = ""
                containerHeight = uiView.contentSize.height
                buttonState = false
            }
        }
    }
    
    
    
    
    class Coordinator: NSObject, UITextViewDelegate {
        //读取所有的父属性
        var  parent: AutoSizingTF
        init(parent: AutoSizingTF) {
            self.parent = parent
        }
        

        // auto clear the box when user clicks the box
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.hint {
                textView.text = ""
                textView.textColor = UIColor(Color.primary)
            }
        }
        
        

        //check if view did change
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            parent.containerHeight = textView.contentSize.height
        }
        
        
        
        //检查文本框是否内容为空，如果为空则用hint的值覆盖
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                //覆盖组件
                print("now textView.text is empty")
                textView.text = parent.hint
                textView.textColor = .gray
            }
        }
        
      
        

        
        
    }
}
