//
//  CustomTextField.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 22/05/23.
//

import SwiftUI

struct CustomTextField: View {
    var title: String
    var prompt: String
    var type: TextFieldType = .name
    @Binding var text: String
    @State var showTitle = true
    
    var body: some View {
        VStack(alignment: .leading) {
            if showTitle {
                Text(title)
                    .padding(.horizontal)
            }
            TextField("", text: $text, prompt: Text(prompt))
                .labelsHidden()
                .textFieldStyle(CustomTextFieldStyle(type: type))
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(title: "Titolo del txt", prompt: "Scrivi qui", text: .constant(""))
    }
}
