//
//  SearchBar.swift
//  BestBar
//
//  Created by Chris McLearnon on 16/06/2020.
//  Copyright © 2020 BelfastLabs. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Binding var text: String
    @State private var isEditing = false
    
    var body: some View {
       HStack {
           TextField("Search ...", text: $text)
           .padding(7)
           .padding(.horizontal, 25)
            .background(self.colorScheme == .dark ? Color(.systemGray4) : Color(.systemFill))
           .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(UIColor.systemBackground))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
             
                    if isEditing {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
           .padding(.horizontal, 10)
           .onTapGesture {
               self.isEditing = true
           }

           if isEditing {
               Button(action: {
                   self.isEditing = false
                   self.text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

               }) {
                   Text("Cancel")
               }
               .padding(.trailing, 10)
               .transition(.move(edge: .trailing))
               .animation(.default)
           }
       }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
