//
//  EditCommentView.swift
//  Firebase-SwiftUI-MVVM
//
//  Created by Michael Haslam on 5/29/21.
//

import SwiftUI

struct EditCommentView: View {
    @State var editedText = ""
    var textToEdit: String
    init(textToEdit: String) {
        self.textToEdit = textToEdit
        self._editedText = State(wrappedValue: textToEdit)
    }
    
    var body: some View {
        HStack {
            TextField("", text: $editedText)
                .padding(.horizontal)
                .frame(height: 40)
            Button(action: {
               editComment()
            }) {
                Text("Save")
            }
            .padding(.trailing)
            }
        .background(Color("BrandPrimary").opacity(0.05))
        .cornerRadius(10)
        .padding()
        
    }
    private func editComment() {
        print(editedText)
        editedText = ""
    }
}
