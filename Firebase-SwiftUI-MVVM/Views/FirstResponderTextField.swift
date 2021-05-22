//
//  FirstResponderTextField.swift
//  Firebase-SwiftUI-MVVM
//
//  Created by Michael Haslam on 5/22/21.
//

import SwiftUI

struct FirstResponderTextField: UIViewRepresentable {
    @Binding var text: String
    let placeholder: String
     

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        var becameFirstResponder = false
        
        init(text: Binding<String>) {
            _text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> some UIView{
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.attributedPlaceholder = NSAttributedString(string:  placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }

   
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if !context.coordinator.becameFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.becameFirstResponder = true
        }
    }
}
