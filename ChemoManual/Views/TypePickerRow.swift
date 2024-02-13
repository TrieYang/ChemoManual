//
//  TypePickerRow.swift
//  ChemoManual
//
//  Created by Trie Yang on 2023-11-07.
//

import SwiftUI

struct TypePickerItem: View {
    @Binding var selection: Type?
    var type: Type
    
    var body: some View {
//        Button {
//            selection = type
//        } label: {
//            Label(selection: $selection, type: type)
//        }
        Label(selection: $selection, type: type)
        
    }
}

private struct Label: View {
    @Binding var selection: Type?
    var type: Type
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 20) {
                Image(systemName: type.imageName)
                    .font(.title)
                    .foregroundStyle(shapeStyle(Color.accentColor))
                VStack(alignment: .center) {
                    Text(type.localizedName)
                        .bold()
                        .foregroundStyle(shapeStyle(Color.primary))
                    Text(type.localizedDescription)
                        .font(.callout)
                        .lineLimit(3, reservesSpace: true)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(shapeStyle(Color.secondary))
                }
                Spacer()
            }
            .frame(
                maxWidth: .infinity
                
            )
            
            .padding()
            .cornerRadius(10)
            //      .border()
            .shadow(radius: 0.5)
            Divider()
        }
        
        
        
    }
    
    func shapeStyle<S: ShapeStyle>(_ style: S) -> some ShapeStyle {
        if selection == type {
            return AnyShapeStyle(.background)
        } else {
            return AnyShapeStyle(style)
        }
    }
}

struct ExperiencePickerItem_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(Type.allCases) {
            TypePickerItem(selection: .constant(nil), type: $0)
            TypePickerItem(selection: .constant($0), type: $0)
        }
    }
}


