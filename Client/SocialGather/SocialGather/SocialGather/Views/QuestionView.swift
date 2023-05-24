//
//  QuestionView.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 24/05/23.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var partyViewModel: PartyViewModel
    @State var doneQuestion = false
    @State var selected = false
    @State var step = 0
    @State var question = Question(text: "", answers: [""], correctAnswer: "")
    var body: some View {
        ZStack {
            Color.Background
                .ignoresSafeArea()
            QuestionCard(question: question.text, rightAnswer: question.correctAnswer, answers: question.answers)
        }
        .onAppear{
            partyViewModel.getQuestion(partyCode: partyViewModel.currentParty.code, index: partyViewModel.currentQuestion, completion: { question in
                self.question =  question!
            })
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
