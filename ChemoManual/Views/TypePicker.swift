//
//  TypePicker.swift
//  ChemoManual
//
//  Created by Trie Yang on 2023-11-07.
//

import SwiftUI

struct TypePicker: View {
    @Binding var type: Type?
    @Environment(\.dismiss) private var dismiss
    @State private var selection: Type?
    @State private var isTapped: Bool = false
    @ObservedObject var data: DataReader
    var body: some View {
        NavigationView {
            
                
            VStack {
                ScrollView {
                    Spacer()
                    Text("Post Categories")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineLimit(2, reservesSpace: true)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.8)
                        .padding()
                    Spacer()
                    LazyVGrid(columns: columns) {
                        ForEach(Type.allCases) { type in
                            NavigationLink(destination: FilteredCards(data: data, filterType: type)) {
                                TypePickerItem(
                                    selection: $selection,
                                    type: type)
                                
                            }.simultaneousGesture(TapGesture().onEnded{
                                print("I am here in the action")
                                self.isTapped.toggle()
                            })
                            
                           
                       
                            
                        }
                    }
                                                  
                    Spacer()
//                    NavigationLink(destination: Text("Hi")) {
// //                       ContinueButton(action: continueAction)
//   //                         .disabled(selection == nil)
//     //                       .scenePadding()
//                        Text("Continue")
////
//                    }
//                    .simultaneousGesture(TapGesture().onEnded{
//                        print("I am here in the action")
//                        self.isTapped.toggle()
  
                   //})

                }
            }
                .scenePadding()
                
            }
            

        
        
        .interactiveDismissDisabled(selection == nil)
    }
    
    var columns: [GridItem] {
        [ GridItem(.adaptive(minimum: 250)) ]
    }
    
    func continueAction() {
        type = selection
        dismiss()
    }
}

//struct ExperiencePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ForEach(Type.allCases + [nil], id: \.self) {
//            TypePicker(type: .constant($0))
//        }
//    }
//}


