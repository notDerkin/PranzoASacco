//
//  Styling.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 22/05/23.
//

import SwiftUI

// MARK: - Font
extension Font {
    /// More playful font. Black. Used for titles
    static let customTitle = Font.custom("Livvic-Bold", size: 34)
}

// MARK: - Colors
extension Color {
    static let text = Color("Text")
    static let CorrectGreen = Color("CorrectGreen")
    static let Background = Color("Background")
}

// MARK: - Buttons
enum ButtonType {
    case filled, stroke
}

/// Orange fill color, corner radius 8.
struct CustomButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    var buttonType: ButtonType
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            // Background
            if buttonType == .filled {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.accentColor)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .frame(maxHeight: 47)
                    .opacity(isEnabled ? 1 : 0.1)
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .stroke()
                    .foregroundColor(Color.accentColor)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .frame(maxHeight: 47)
            }
            
            // Content
            configuration.label
            
                .foregroundColor(buttonType == .filled ? .white : .accentColor)
                .padding(.vertical, 13)
                .font(.system(size: 17, weight: .regular))
        }
        .opacity(configuration.isPressed ? 0.7 : 1)
        .padding()
    }
}

/// Black fill color, corner radius 8.
struct CustomButtonStyleDisabled: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    var buttonType: ButtonType
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            // Background
            if buttonType == .filled {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.accentColor)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .frame(maxHeight: 47)
                    .opacity(0.1)
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .stroke()
                    .foregroundColor(Color.accentColor)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .frame(maxHeight: 47)
                    .opacity(0.1)
            }
            
            // Content
            configuration.label
            
                .foregroundColor(buttonType == .filled ? .white : .accentColor)
                .padding(.vertical, 13)
                .font(.system(size: 17, weight: .regular))
                .disabled(true)
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - TextFields

enum TextFieldType {
    case wrongAnswer, rightAnswer, question, bordered, code, name
}

/// Textfield with border and corner radius of 8. Type defines if it's for wrong or right answer, or none.
struct CustomTextFieldStyle: TextFieldStyle {
    var type: TextFieldType
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            // Background
            if type == .rightAnswer {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.green)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .frame(maxHeight: 47)
                configuration
                    .padding()
            } else if type == .wrongAnswer{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.red)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .frame(maxHeight: 47)
                configuration
                    .padding()
            } else if type == .question {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.secondary.opacity(0.5))
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .frame(maxHeight: 47)
                configuration
                    .padding()
            } else if type == .bordered {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.secondary)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .frame(maxHeight: 47)
                configuration
                    .padding()
            } else if type == .name {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .frame(maxHeight: 47)
                configuration
                    .padding()
            } else if type == .code {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .frame(maxHeight: 47)
                configuration
                    .padding()
                    .keyboardType(.numberPad)
            }
        }
        .padding(.horizontal, 20)
        .autocorrectionDisabled()
    }
}

// MARK: - Test

struct TestTextField: View {
    @State var txt = ""
    var body: some View {
        Button("Hello") {}
            .buttonStyle(CustomButtonStyle(buttonType: .filled))
    }
}

struct TestButton_Preview: PreviewProvider {
    static var previews: some View {
        TestTextField()
    }
}
