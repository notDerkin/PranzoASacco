//
//  QuestionCard.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 24/05/23.
//

import SwiftUI

struct QuestionCard: View {
    @EnvironmentObject var partyViewModel: PartyViewModel
    @State var doneQuestion = false
    var question: String
    var rightAnswer: String
    var answers: [String] = []
    var body: some View {
        VStack(alignment: .leading) {
            Text("Round \(partyViewModel.currentQuestion)")
                .font(.customTitle)
                .foregroundColor(.text)
            CustomPageController(doneQuestion: $doneQuestion)
            Spacer()
                .frame(maxHeight: 37)
            Text(question)
                .font(.headline)
                .bold()
            
            ForEach(answers, id: \.self) { answer in
                AnswerBox(content: answer, boxType: partyViewModel.isMaster ? answer == rightAnswer ? .correct : .wrong : .none, correctAnswer: rightAnswer)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - 220)
        }
    }
}

//struct QuestionCard_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionCard(question: "This is the question", rightAnswer: "This is the right answer", wrongAnswer1: "This is a wrong answer", wrongAnswer2: "This is a wrong answer", wrongAnswer3: "This is a wrong answer")
//    }
//}
