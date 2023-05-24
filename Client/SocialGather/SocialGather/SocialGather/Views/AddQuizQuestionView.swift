//
//  AddQuizQuestionView.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 23/05/23.
//

import SwiftUI

struct AddQuizQuestionView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var partyViewModel: PartyViewModel
    @State var title = ""
    @State var question = ""
    @State var rightAnswer = ""
    @State var wrongAnswer1 = ""
    @State var wrongAnswer2 = ""
    @State var wrongAnswer3 = ""
    var body: some View {
        ZStack {
            VStack {
                Header(title: title)
                    .padding(.top)
                Spacer()
                    .frame(maxHeight: 40)
                CustomTextField(title: "Question", prompt: "Write the question here", type: .question, text: $question)
                
                Spacer()
                    .frame(maxHeight: 40)
                
                CustomTextField(title: "Correct Answer", prompt: "Write the correct answer", type: .rightAnswer, text: $rightAnswer)
                Spacer()
                    .frame(maxHeight: 40)
                Group {
                    CustomTextField(title: "Wrong Answers", prompt: "Write the wrong answer", type: .bordered, text: $wrongAnswer1)
                    if wrongAnswer1 != "" {
                        CustomTextField(title: "Wrong Answers", prompt: "Write the wrong answer", type: .bordered, text: $wrongAnswer2, showTitle: false)
                    }
                    if wrongAnswer1 != "" && wrongAnswer2 != "" {
                        CustomTextField(title: "Wrong Answers", prompt: "Write the wrong answer", type: .bordered, text: $wrongAnswer3, showTitle: false)
                    }
                }
                Spacer()
                Group {
                    if wrongAnswer3 == "" {
                        Button("Done") {}
                        .buttonStyle(CustomButtonStyleDisabled(buttonType: .filled))
                        .padding(.bottom)
                    } else {
                        Button("Done") {
                            partyViewModel.questions.append(Question(text: question, answers: [rightAnswer, wrongAnswer1, wrongAnswer2, wrongAnswer3], correctAnswer: rightAnswer))
                            presentation.wrappedValue.dismiss()
                        }
                        .buttonStyle(CustomButtonStyle(buttonType: .filled))
                        .padding(.bottom)
                    }
                }
            }
        }
    }
}

struct AddQuizQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        AddQuizQuestionView()
    }
}
