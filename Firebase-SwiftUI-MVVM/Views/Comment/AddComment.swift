//
//  AddComment.swift
//  Firebase-SwiftUI-MVVM
//
//  Created by Michael Haslam on 5/22/21.
//

import SwiftUI

struct AddCommentView: View {
    @Environment(\.presentationMode) var presentationMode
    // Auto Updating TextBox Height...
    @State var containerHeight: CGFloat = 0

    @State var text: String = ""
    
    var body: some View {
        HStack {
            AutoSizingTextField(hint: "Add Comment", text: $text, containerHeight: $containerHeight) {
                print(text)
                text = ""
                print("value",text)
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .padding(.horizontal)
            // Your Max Height Here....
            .frame(height: containerHeight <= 120 ? containerHeight : 120)
            .background(Color("BrandPrimary").opacity(0.05))
            .cornerRadius(10)
            .padding()
        }
    }
    
    private func addComment() {
        print("Add Comment Called")
    }
}

struct AddComment_Previews: PreviewProvider {
    static var previews: some View {
        AddCommentView()
    }
}
